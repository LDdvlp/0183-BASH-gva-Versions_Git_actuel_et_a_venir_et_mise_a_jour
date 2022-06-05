#!/bin/bash

##
# gva.sh
#
# Affiche les numéros de version de Git pour Windows
# actuel et à venir, et propose la mise à jour
#
# Usage :
# gva

# *** ************************************************************************************** *** 

# Fichier temporaire pour numéro de version actuel de Git
temp_file_1="nowGitVersion.txt"
# Url de la dernière version de Git 
latest_source_release_url="https://git-scm.com/downloads"
# Fichier temporaire pour dernier numéro de version de Git
temp_file_2="latestGitVersion.txt"

# *** ************************************************************************************** *** 

# Extraction du numéro de version actuel
nowVersion=`git --version`
echo ${nowVersion} > ${myPath100}${temp_file_1}
nowVersion=`cut -d ' ' -f 3 ${myPath100}${temp_file_1}`
echo ${nowVersion} > ${myPath100}${temp_file_1}
nowVersion=`cut -d '.' -f 1-3 ${myPath100}${temp_file_1}`
echo ${nowVersion} > ${myPath100}${temp_file_1}

# *** ************************************************************************************** *** 

# Extraction du numéro de version à venir


# Télécharge HTML dernière version de Git dans fichier latestGitVersion.txt
# Paramètre --silent : supprime les statistiques 
curl --silent ${latest_source_release_url} > ${myPath100}${temp_file_2}

# Récupération HTML partiel dans une variable, comprenant le dernier numéro de version de Git
latestVersion=`grep -A 1 "span class=\"version\"" ${myPath100}${temp_file_2}`

# Envoi le l'extraction de texte dans le fichier temporaire (Réécriture totale)
echo ${latestVersion} > ${myPath100}${temp_file_2}

# Découpage du numéro de version dans une variable
latestVersion=`cut -d ' ' -f 3 ${myPath100}${temp_file_2}`
echo ${latestVersion} > ${myPath100}${temp_file_2}

# *** ************************************************************************************** *** 

# Affichage des versions de Git pour Windows
echo ""
echo "************************************"
echo "*   Versions de Git pour Windows   *"
echo "************************************"
echo ""
echo "Version installée : ${nowVersion}"
echo "Dernière version  : ${latestVersion}"
echo ""

# Récupération des nombres des numéros de versions dans des variables
nowVersionNumber_1=`cut -d '.' -f 1 ${myPath100}${temp_file_1}`
latestVersionNumber_1=`cut -d '.' -f 1 ${myPath100}${temp_file_2}`

nowVersionNumber_2=`cut -d '.' -f 2 ${myPath100}${temp_file_1}`
latestVersionNumber_2=`cut -d '.' -f 2 ${myPath100}${temp_file_2}`

nowVersionNumber_3=`cut -d '.' -f 3 ${myPath100}${temp_file_1}`
latestVersionNumber_3=`cut -d '.' -f 3 ${myPath100}${temp_file_2}`

### TESTING ###################################################################################################################################
#echo "Version installée en numéros décomposés        : ${nowVersionNumber_1}  ${nowVersionNumber_2}  ${nowVersionNumber_3}"
#echo "Dernière version en numéros décomposés         : ${latestVersionNumber_1}  ${latestVersionNumber_2}  ${latestVersionNumber_3}"

#latestVersionNumber_1=2
#latestVersionNumber_2=37
#latestVersionNumber_3=4
#echo "Dernière version fictive en numéros décomposés : ${latestVersionNumber_1}  ${latestVersionNumber_2}  ${latestVersionNumber_3}"

#echo ""

#dl()
##{
#    information="Mise à jour possible, suite à comparaison au nombre numéro ${1} dans le numéro de version."
#    echo "${information}"
#}
### TESTING ###################################################################################################################################

# Définitions des fonctions de mise à jour et confirmation

miseAJourGitPourWindows()
{
    echo ""
    git update-git-for-windows
    ### TESTING ###
    #echo ""
    #echo "Mise en jour en cours ..."
    ### TESTING ###
}

suppressionFichiersTemporaires()
{
    rm ${myPath100}${temp_file_1}
    rm ${myPath100}${temp_file_2}
}

confirmationMiseAJour()
{   suppressionFichiersTemporaires
    read -p "Télecharger et mettre à jour ? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    miseAJourGitPourWindows
}

informationDerniereVersionInstallee()
{
    echo "Dernière version installée, donc pas de mise à jour."
    suppressionFichiersTemporaires
}

# Comparaison des numéros de versions

if [[ "${nowVersionNumber_1}" -lt "${latestVersionNumber_1}" ]]
then
    ### TESTING ###
    #dl "1"
    ### TESTING ###
    confirmationMiseAJour    
    elif [[ "${nowVersionNumber_2}" -lt "${latestVersionNumber_2}" ]]
    then
        ### TESTING ###
        #dl "2"
        ### TESTING ###
        confirmationMiseAJour
        elif [[ "${nowVersionNumber_3}" -lt "${latestVersionNumber_3}" ]]
        then
            ### TESTING ###
            #dl "3"
            ### TESTING ###
            confirmationMiseAJour
            else
                informationDerniereVersionInstallee
fi
