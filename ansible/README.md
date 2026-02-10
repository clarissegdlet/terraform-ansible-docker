# Terraform & Ansible – Docker Platform TD

## Contexte
Mise en place d’un socle reproductible pour un service conteneurisé.
Terraform est utilisé pour le provisionnement Docker.
Ansible intervient uniquement pour la validation et l’hygiène minimale.

## Architecture
- Réseau Docker dédié
- Volume Docker persistant
- Container Nginx
- Port externe configurable
- Validation locale via Ansible

## Terraform
Terraform provisionne l’ensemble de l’infrastructure :
- réseau
- volume
- image
- container

Les outputs exposent les informations nécessaires à l’exploitation
(URL, port, nom et ID du container).

## Ansible
Ansible est utilisé uniquement en lecture :
- validation HTTP du service
- vérification de l’état du container
- vérification du port exposé
- vérification de la restart policy

Aucune modification de l’infrastructure n’est effectuée.

## Séparation des rôles
Terraform gère le cycle de vie de l’infrastructure.
Ansible valide l’état du runtime sans reconfigurer.

## Évolution CI/CD
Ce socle peut être intégré dans un pipeline CI/CD :
- Terraform pour le provisioning
- Ansible pour la validation post-déploiement
- Ajout possible de tests de sécurité et de monitoring

## Pourquoi séparer provisionnement et validation ?
La séparation entre provisionnement et validation permet de définir le rôle et les responsabilités de chaque outil. Terraform est utilisé pour créer et gérer l’infrastructure de manière déclarative et reproductible, tandis qu’Ansible intervient uniquement pour vérifier l’état réel du système après déploiement.

## En quoi les outputs Terraform facilitent l'automomatisation ?
Les outputs Terraform exposent des informations clés sur l’infrastructure déployée, telles que l’URL du service, le port exposé ou l’identifiant du container. Grâce aux outputs, il est possible d’automatiser des étapes post-déploiement sans avoir à inspecter l’état Terraform ni à dupliquer de la configuration.

## Quelle est la valeur d'Ansible dans un rôle de non configurant ?
Dans un rôle non configurant, Ansible apporte une forte valeur en tant qu’outil de validation et de contrôle de conformité.
Il permet de vérifier que l’infrastructure et les services respectent les attentes sans modifier l’existant.

## Comment ce socle évoluerait vers un environnement CI/CD ?
Ce socle peut être intégré dans un pipeline CI/CD en automatisant les différentes étapes.
Terraform serait exécuté dans le pipeline pour provisionner l’infrastructure, tandis qu’Ansible interviendrait comme étape de validation post-déploiement.

## Preuves de validation

### Outputs Terraform
container_id = "2023d649fe5b069f87b69bd4f2085a7a7322367f3f2579913adf04ac02728ef5"
container_name = "nginx-platform"
external_port = 8080
service_url = "http://localhost:8080"

### Test HTTP avec curl
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

### Logs Ansible sur Ubuntu 
PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
