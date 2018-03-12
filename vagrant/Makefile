.PHONY: all
all: vsp/vsp.env msa/msa.env

.PHONY: clean
clean:
	rm -f vsp/vsp.env
	rm -rf vsp/pki
	rm -f msa/msa.env
	rm -rf msa/pki

vsp/vsp.env: vsp/pki vsp/pki/signing-private-key.pk8 vsp/pki/signing-certificate.crt vsp/pki/encryption-private-key.pk8 vsp/pki/encryption-certificate.crt
	./vsp/vsp.env.template > $@

vsp/pki:
	mkdir vsp/pki

msa/msa.env: msa/pki msa/pki/signing-private-key.pk8 msa/pki/signing-certificate.crt msa/pki/encryption-private-key.pk8 msa/pki/encryption-certificate.crt
	./msa/msa.env.template > $@

msa/pki:
	mkdir msa/pki

%.pk8: %.pem
	openssl pkcs8 -topk8 -inform PEM -outform DER -in $< -nocrypt -out $@

%.crt: %.pem
	openssl req -batch -new -subj "/CN=$$RANDOM" -key $< | openssl x509 -req -sha256 -signkey $< -out $@

%.pem:
	openssl genrsa -des3 -passout pass:x 2048 | openssl rsa -passin pass:x -out $@
