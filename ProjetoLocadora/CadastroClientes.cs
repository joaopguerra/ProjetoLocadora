using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


namespace ProjetoLocadora
{
    public partial class CadastroDeClientes : Form
    {

        public CadastroDeClientes()
        {
            InitializeComponent();
        }

        private void CadastroDeClientes_Load(object sender, EventArgs e)
        {

        }

        private void btnCadastrar_Click(object sender, EventArgs e)
        {

            try
            {
                Clientes clientes = new Clientes();
                clientes.nome = txtNome.Text;
                clientes.telefone = txtTelefone.Text;
                clientes.cpf = txtCPF.Text;
                clientes.email = txtEmail.Text;

                /*Conexão com o BD e inserindo na tb_clientes*/
                MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                CON.Open();
                MySqlCommand CM = new MySqlCommand("INSERT INTO usuario(Id_Usuario, Nome, Telefone, CPF, email)"
                    + "VALUES (null, ?, ?, ?, ?)", CON);

                /*Parameter irá substituir os valores dentro do campo*/
                CM.Parameters.Add("@Nome", MySqlDbType.VarChar, 45).Value = clientes.nome;
                CM.Parameters.Add("@Telefone", MySqlDbType.VarChar, 45).Value = clientes.telefone;
                CM.Parameters.Add("@CPF", MySqlDbType.VarChar, 45).Value = clientes.cpf;
                CM.Parameters.Add("@Email", MySqlDbType.VarChar, 100).Value = clientes.email;


                CM.ExecuteNonQuery();

                txtNome.Text = "";
                txtTelefone.Text = "";
                txtCPF.Text = "";
                txtEmail.Text = "";

                MessageBox.Show("Cadastro realizado com sucesso!");
                CON.Close();
            }

            catch (Exception ex)
            {
                MessageBox.Show("Cadastro não realizado!" + ex);
            }
        }

        private void btnDeletar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Tem certeza que deseja excluir?", "Cuidado", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.No)
            {
                MessageBox.Show("Operação cancelada!");
            }

            else
            {
                try
                {
                    /*Conexão com o BD e inserindo na tb_clientes*/
                    MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                    CON.Open();
                    MySqlCommand CM = new MySqlCommand("DELETE FROM usuario where Id_Usuario = ?", CON);

                    /*Parameter irá substituir os valores dentro do campo*/
                    CM.Parameters.Add("Id_Usuario", MySqlDbType.Int32).Value = txtID.Text;


                    CM.ExecuteNonQuery();

                    txtNome.Text = "";
                    txtTelefone.Text = "";
                    txtCPF.Text = "";
                    txtEmail.Text = "";

                    MessageBox.Show("Registro deletado com sucesso!");
                    CON.Close();
                }

                catch (Exception ex)
                {
                    MessageBox.Show("Operação não realizado!" + ex);
                }

            }
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                Clientes clientes = new Clientes();
                clientes.nome = txtNome.Text;
                clientes.telefone = txtTelefone.Text;
                clientes.cpf = txtCPF.Text;
                clientes.email = txtEmail.Text;

                /*Conexão com o BD e inserindo na tb_clientes*/
                MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                CON.Open();
                MySqlCommand CM = new MySqlCommand("UPDATE usuario set Nome = ?, Telefone = ?, CPF = ?, email = ? WHERE Id_usuario = ?", CON);

                /*Parameter irá substituir os valores dentro do campo*/
                CM.Parameters.Add("@Nome", MySqlDbType.VarChar, 45).Value = clientes.nome;
                CM.Parameters.Add("@Telefone", MySqlDbType.VarChar, 45).Value = clientes.telefone;
                CM.Parameters.Add("@CPF", MySqlDbType.VarChar, 45).Value = clientes.cpf;
                CM.Parameters.Add("@Email", MySqlDbType.VarChar, 100).Value = clientes.email;
                CM.Parameters.Add("Id_usuario", MySqlDbType.Int32).Value = txtID.Text;


                CM.ExecuteNonQuery();

                MessageBox.Show("Cadastro editado com sucesso!");
                CON.Close();
            }

            catch (Exception ex)
            {
                MessageBox.Show("Cadastro não realizado!" + ex);
            }
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                /*Conexão com o BD e buscando na tabela usuario*/
                MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                CON.Open();
                MySqlCommand CM = new MySqlCommand("SELECT Nome, Telefone, CPF, Email FROM usuario WHERE Id_Usuario = ?", CON);
                CM.Parameters.Add("Id_Usuario", MySqlDbType.Int32).Value = txtID.Text;

                //executa o comando
                CM.CommandType = CommandType.Text;
                //recebe o conteúdo que vem do banco
                MySqlDataReader DR;
                DR = CM.ExecuteReader();
                //insere as informações recebidas do banco para os componentes do form
                DR.Read();
                txtNome.Text = DR.GetString(0);
                txtTelefone.Text = DR.GetString(1);
                txtCPF.Text = DR.GetString(2);
                txtEmail.Text = DR.GetString(3);
            }

            catch (Exception ex)
            {
                MessageBox.Show("ID não encontrado!");
            }
        }

        private void listaGrid()
        {
            /*Conexão com o BD*/ 
            MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
            CON.Open();
            MySqlCommand CM = new MySqlCommand("SELECT * FROM usuario", CON);
            //Nome, Telefone, CPF, Email FROM usuario WHERE Id_Usuario = ?

            try
            {
                MySqlDataAdapter objAdp = new MySqlDataAdapter(CM);
                DataTable dtLista = new DataTable();
                objAdp.Fill(dtLista);
                TabelaDados.DataSource = dtLista;
            }

            catch
            {
                MessageBox.Show("ERRO");
            }
        }

        private void btnListar_Click(object sender, EventArgs e)
        {
            listaGrid();
        }
    }
}
