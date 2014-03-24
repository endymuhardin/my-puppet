# Puppet Script untuk Laptop #

Otomasi instalasi laptop menggunakan [Puppet](http://puppetlabs.com/)

## Modules ##

* Base Ubuntu : definisi source list apt-get yang mengarah ke repo Kambing
* Base Desktop : aplikasi-aplikasi yang digunakan sehari-hari
* Fotografi : aplikasi-aplikasi fotografi
* Programming Java : aplikasi untuk pemrograman Java
* Programming JavaScript : NodeJS dkk
* Database MySQL
* Database PostgreSQL
* Database MongoDB
* Database Redis

## Node ##

* My Laptop

## Cara Pemakaian ##

1. Install Repository Puppet [dari sini](https://apt.puppetlabs.com/), pilih sesuai rilis Ubuntu
2. Install Puppet: `apt-get update && apt-get install puppet -y`
3. Install modul apt : `puppet module install --modulepath=/path/ke/folder/module puppetlabs/apt`
4. Apply config yang diinginkan: `puppet apply --verbose --modulepath=/path/ke/folder/module nodes/breadwinner.pp`
5. Bisa juga apply module satu persatu : `puppet apply --verbose --modulepath=/path/ke/folder/module -e "include ubuntubase,ubuntudesktop"`
