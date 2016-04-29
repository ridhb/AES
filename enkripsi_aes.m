% clc, clear all
function  [outputciph_aes] = enkripsi_aes(inputplain_aes, kunci_aes)
load parameter 
plainteks_bit=inputplain_aes;
plaintext_susun=reshape(plainteks_bit,8,16)';
plaintext=bi2de(plaintext_susun,'left-msb');
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
load parameter_poly
state = reshape (plaintext, 4, 4);
round_key = (w(1:4, :))';
state = bitxor (state, round_key);
for i_round = 1 : 9
    state = s_box (state + 1);
    state = cycle (state, 'left');
    state = mix_columns (state, poly_mat);
    round_key = (w((1:4) + 4*i_round, :))';
    state = bitxor (state, round_key);
end
state = s_box (state + 1);
state = cycle (state, 'left');
round_key = (w(41:44, :))';
state = bitxor (state, round_key);
ciphertext_de = reshape (state, 1, 16);
ciphertext_bi_ngaco=de2bi(ciphertext_de,8,'left-msb');
[pjg klm]=size(ciphertext_bi_ngaco);
ciphertext_bi=reshape(ciphertext_bi_ngaco',1,pjg*klm);
outputciph_aes=ciphertext_bi;
