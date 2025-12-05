# 🌆 Desafio dos Sensores Urbanos (Agora com invocação remota entre Cloud <-> Processador)

Projeto desenvolvido para a disciplina de **Sistemas Distribuídos**.  
O desafio simula o uso de sensores de **temperatura, umidade e insolação** espalhados em cinco bairros de uma cidade.  
Esses sensores enviam dados solicitados para um **gateway**, que depois escuta as solicitações da **cloud** e, por fim, repassa e recebe os dados tratados do **processador** e armazena em um "Banco de Dados".

---

## 📌 Objetivo
- Compreender a comunicação entre processos usando **Sockets em JavaScript (Node.js)**.  
- Criar uma arquitetura distribuída capaz de:
  1. Gerar dados simulados a partir de sensores (dados aleatórios).  
  2. Coletar dados dos sensores no gateway.
  3. Coletar dados do gateway no cloud.
  4. Repassar dados recebidos do cloud para o processador.
  5. Processar os dados no processador (cálculo de médias).  
  6. Receber dados do processador e armazenar em um Banco de Dados.

---

## 🏗️ Arquitetura da Solução

Sensores → Gateway ↔ Cloud ↔ Processador

```yaml
- **Sensores:** (SERVIDOR) geram valores aleatórios de temperatura, umidade e insolação.  
- **Gateway:** (SERVIDOR/CLIENTE) recebe dados dos Sensores, agrega e envia ao cloud quando solicitado.    
- **Cloud:** (CLIENTE/CLIENTE) recebe dados do Gateway, chama uma função remota do Processador como se fosse local. O gRPC cuida de enviar pela rede, serializar, deserializar e validar. A resposta já vem pronta (response.medias), e grava os resultados em dados_cloud.txt
- **Processador:** (SERVIDOR) Recebe do Cloud automaticamente um objeto call.request.dados já convertido e validado. Chama a função calcularMedias. Retorna o resultado diretamente via callback.
```

---

## ⚙️ Tecnologias Utilizadas
- **Node.js** (JavaScript)  
- **Módulo `net`** para comunicação por sockets TCP  
- **Console** para simular a Cloud (sem banco de dados)  

---

## 📂 Estrutura do Projeto

```bash
/sensores-urbanos
├── sensor.ts # Simula sensores de cada bairro
├── gateway.ts # Agregador de dados (central)
├── processador.ts # Calcula médias por bairro
├── cloud.ts # Simulação da Cloud
├── README.md # Documentação do projeto
└── start.bat # Simula as 8 maquinas abrindo vários prompts de comando (Por favor não se assuste 👻😂)
```

---

## ▶️ Como Executar

1. **Clone o repositório**  
   ```bash
   git clone https://github.com/seu-usuario/sensores-urbanos.git
   cd sensores-urbanos
   ```
Abra 4 terminais diferentes e rode nessa ordem:

Gateway

```bash
npx ts-node gateway.ts
```

Processador
```bash
npx ts-node processador.ts
```

Cloud
```bash
npx ts-node cloud.ts
```

Sensores (um por bairro)
```bash
npx ts-node sensor.ts Centro 5000
npx ts-node sensor.ts Norte 5001
npx ts-node sensor.ts Sul 5002
npx ts-node sensor.ts Leste 5003
npx ts-node sensor.ts Oeste 5004
```

🔍 Exemplo de Saída
Sensor
```bash
Sensor Centro rodando em 127.0.0.1:5000
Gateway conectado ao sensor do bairro Centro (porta 5000)`
```

Gateway
```bash
Gateway aguardando Cloud em 127.0.0.1:6000
Cloud conectado ao Gateway
Cloud requisitou dados -> consultando sensores...
Solicitando dados do Sensor na porta 5000
```

Processador
```bash
Processador aguardando Cloud em 127.0.0.1:7000
Cloud conectado ao Processador
Processador calculou::
{
  Centro: { temperatura: '23.0', umidade: '66.0', insolacao: '500.0' },
  Norte:  { temperatura: '20.5', umidade: '70.0', insolacao: '600.0' }
}
```

Cloud
```bash
Cloud recebeu do Gateway::
{
  Centro: { temperatura: '23.0', umidade: '66.0', insolacao: '500.0' },
}
Cloud recebeu do Processador:
{
  Centro: { temperatura: '23.0', umidade: '66.0', insolacao: '500.0' },
}
```