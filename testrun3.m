clc, clear all
plain(1,:)=randint(1,128)
key=randint(1,128);
cipher=enkripsi_aes(plain(1,:), key);
plain(2,:)=dekripsi_aes(cipher, key)
