Mini-projet: Déployez un serveur jenkins
Contexte
Il s'agit d'écrire plusieurs modules permettant de reproduire le déploiement de façon très aisée d'un serveur jenkins sur AWS, et ensuite d'exporter un certain nombre de métadonnées produites lors de l'exécution dans un fichier texte qui se trouvera sur notre machine Terraform.

Etapes à réaliser
Ecrivez un module pour créer une instance ec2 utilisant la version ubuntu jammy (qui s’attachera l’ebs et l’ip publique) dont la taille et le tag seront variabilisés
Ecrivez un module pour créer un volume ebs dont la taille sera variabilisée
Ecrivez un module pour une ip publique (qui s’attachera la security group)
Ecrivez un module pour créer une security qui ouvrira les ports 80, 443 et 8080
Ecrivez un module pour créer une paire de clés de facon dynamique pour la connexion à l'ec2
Créez un dossier app qui va utiliser les 5 modules pour déployer une ec2, bien-sûr vous allez surcharger les variables afin de rendre votre application plus dynamique
A la fin du déploiement, installez Jenkins et enregistrez l’ip publique et le nom de domaine dans un fichier nommé jenkins_ec2.txt


Solution :
Considering you just have cloned this repository, you have to follow those steps to build and test my solution.

1 - Change directory and init terraform projet :

  * cd ./app
  * terraform init 
 You must have this result in your terminal
 ![transform init OK](https://github.com/user-attachments/assets/f7da816b-27a1-4cce-9372-7d5b93501cad)

2 - Execute terraform plan 
  * terraform plan
You must have this result in your terminal
![terraform plan OK](https://github.com/user-attachments/assets/cc5212a1-098b-483b-8abf-2eb6930e820e)
![terraform plan OK 2](https://github.com/user-attachments/assets/29fda3a9-a1cb-49fc-b96f-e6cb451e1b4c)

3 - Excute terraform apply 
  * terraform apply
  * write "Yes" to validate
You must have this result in your terminal
![terraform apply OK](https://github.com/user-attachments/assets/31a3e67f-6ed9-4052-8837-5597748f1135)
![terraform apply OK 2](https://github.com/user-attachments/assets/017cf598-50dd-4137-a22e-c626356438ea)

4 - Check created ressources and devices in AWS Console

  EC2 :
   ![image](https://github.com/user-attachments/assets/6e01fc82-928c-4612-a03a-256a6c1942d6)
    
  EBS : 
    ![image](https://github.com/user-attachments/assets/5034bf54-7bec-4f2d-9543-845d77591e0e)

  EIP :
    ![image](https://github.com/user-attachments/assets/a64cbe92-3785-422b-8aed-87dc5ba84d7e)

  Security-group :
    ![image](https://github.com/user-attachments/assets/e4276187-a68d-464f-bfaa-44cd1bf993cc)

  Dynamic-key :
    ![image](https://github.com/user-attachments/assets/05d96b98-2475-46bb-94df-7a6afbd96fb2)

5 - Verify Jenkins serveur running
    * Connect to your EC2 and look jenkins version 
    * Jenkins --version 
    ![image](https://github.com/user-attachments/assets/3c446fc1-cf0b-4e3f-bb75-9f1e5bdd2a52)

6 - Destroy allowed ressources
    * terrafom destroy
    * write "Yes" to approve
       ![image](https://github.com/user-attachments/assets/a0884876-dd65-4879-91cb-d9b371fb5d4e)
       ![image](https://github.com/user-attachments/assets/f48b5222-149e-4e81-b512-8212d4a28ba5)

Thanks
