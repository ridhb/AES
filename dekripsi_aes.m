% clc, clear all
% function plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, vargin)
function  [outputplain_aes] = dekripsi_aes(inputciph_aes, kunci_aes)

load parameter
load parameter_poly
ciphertext_bi=inputciph_aes;
ciphtext_susun=reshape(ciphertext_bi,8,16)';
ciphertext=bi2de(ciphtext_susun,'left-msb');

key_bit=kunci_aes;
key_susun=reshape(key_bit,8,16)';
key=bi2de(key_susun,'left-msb');

w = (reshape (key, 4, 4))';
for i = 5 : 44   
    temp = w(i - 1, :);
    if mod (i, 4) == 1
        temp = temp([2 3 4 1]);
        temp = s_box (temp + 1);
        r = rcon ((i - 1)/4, :);
        temp = bitxor (temp, r);
    end
    w(i, :) = bitxor (w(i - 4, :), temp);
end

% w = key_expansion (key, s_box, rcon, 1)
state = reshape (ciphertext, 4, 4);
round_key = (w(41:44, :))';
state = bitxor (state, round_key);
for i_round = 9 : -1 : 1
    state = cycle (state, 'right');
    state = inv_s_box (state + 1);
    round_key = (w((1:4) + 4*i_round, :))'; 
    state = bitxor (state, round_key);
    state = mix_columns (state, inv_poly_mat);
    
end
state = cycle (state, 'right');  
state = inv_s_box (state + 1);
round_key = (w(1:4, :))';
state = bitxor (state, round_key);
plaintext_de = reshape (state, 1, 16);

plaintext_bi_ngaco=de2bi(plaintext_de,8,'left-msb');
[pjg klm]=size(plaintext_bi_ngaco);
plaintext_bi=reshape(plaintext_bi_ngaco',1,pjg*klm);
outputplain_aes=plaintext_bi;