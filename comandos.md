# 📌 Comandos Essenciais do Terraform

## 1️⃣ Inicializar o Terraform
```sh
terraform init
```
✅ **O que faz?**  
- Baixa os provedores necessários (como AWS, Azure, GCP).  
- Configura o backend (como S3, para armazenar o estado remoto).  
- Prepara os módulos utilizados no código.  

---

## 2️⃣ Validar a Configuração
```sh
terraform validate
```
✅ **O que faz?**  
- Verifica se a sintaxe do código está correta.  
- Identifica erros estruturais antes da execução.  

---

## 3️⃣ Planejar a Infraestrutura
```sh
terraform plan
```
✅ **O que faz?**  
- Mostra quais recursos serão criados, modificados ou destruídos.  
- Permite revisar antes de aplicar as mudanças.  

---

## 4️⃣ Aplicar as Mudanças
```sh
terraform apply -auto-approve
```
✅ **O que faz?**  
- Cria ou altera os recursos definidos no código.  
- O `-auto-approve` evita a necessidade de confirmar manualmente.  

---

## 5️⃣ Destruir a Infraestrutura
```sh
terraform destroy
```
✅ **O que faz?**  
- Remove todos os recursos criados pelo Terraform.  
- Muito útil para **limpar o ambiente** após testes.  

---

## 6️⃣ Mostrar o Estado Atual
```sh
terraform show
```
✅ **O que faz?**  
- Exibe os recursos gerenciados pelo Terraform.  

---

## 7️⃣ Ver o Estado da Infraestrutura
```sh
terraform state list
```
✅ **O que faz?**  
- Lista todos os recursos controlados pelo Terraform.  

---

## 8️⃣ Remover um Recurso Específico do Estado
```sh
terraform state rm <nome_do_recurso>
```
✅ **O que faz?**  
- Remove um recurso do estado do Terraform **sem deletá-lo na AWS**.  

---

### 📌 Observação
- Sempre valide (`terraform validate`) antes de aplicar (`terraform apply`).  
- Antes de destruir (`terraform destroy`), **tenha certeza do que está fazendo!** 🚀
