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
3. Install modul apt : `puppet module install puppetlabs/apt`
3. Copy isi folder `my-puppet` ke dalam `/etc/puppet`
4. Apply config yang diinginkan: `puppet apply --debug /etc/puppet/nodes/breadwinner.pp`

