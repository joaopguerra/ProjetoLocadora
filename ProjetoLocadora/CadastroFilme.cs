using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjetoLocadora
{
    public partial class CadastroFilme : Form
    {
        public CadastroFilme()
        {
            InitializeComponent();
        }

        private void btnSair_Click(object sender, EventArgs e)
        {
            Close();
            TelaInicial telaInicial = new TelaInicial();
            telaInicial.Show();
        }

        private void txtLancamento_TextChanged(object sender, EventArgs e)
        {
        }

        private void CadastroFilme_Load(object sender, EventArgs e)
        {

        }

        private void btnCadastrar_Click(object sender, EventArgs e)
        {

            try
            {
                /*Conexão com o BD e inserindo na tb_filme*/
                MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                CON.Open();
                MySqlCommand CM = new MySqlCommand("INSERT INTO filme (Id_Filme, Titulo, Produtora, Descricao, NotaFilme, DataLancamento, Categoria)"
                    + "VALUES (null, ?, ?, ?, ?, ?, ?)", CON);

                /*Parameter irá substituir os valores dentro do campo*/
                CM.Parameters.Add("@Titulo", MySqlDbType.VarChar, 45).Value = txtTituloFilme.Text;
                CM.Parameters.Add("@Produtora", MySqlDbType.VarChar, 45).Value = txtProdutora.Text;
                CM.Parameters.Add("@Descricao", MySqlDbType.VarChar, 45).Value = txtDescricao.Text;
                CM.Parameters.Add("@NotaFilme", MySqlDbType.Int32).Value = txtNotaFilme.Text;
                CM.Parameters.Add("@DataLancamento", MySqlDbType.VarChar, 10).Value = txtLancamento.Text;
                CM.Parameters.Add("@Categoria", MySqlDbType.VarChar, 45).Value = txtCategoria.Text;


                CM.ExecuteNonQuery();

                txtTituloFilme.Text = "";
                txtProdutora.Text = "";
                txtDescricao.Text = "";
                txtNotaFilme.Text = "";
                txtLancamento.Text = "";
                txtCategoria.Text = "";

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
                    MySqlCommand CM = new MySqlCommand("DELETE FROM filme where Id_Filme = ?", CON);

                    /*Parameter irá substituir os valores dentro do campo*/
                    CM.Parameters.Add("Id_Filme", MySqlDbType.Int16).Value = txtIDFilme.Text;


                    CM.ExecuteNonQuery();

                    txtTituloFilme.Text = "";
                    txtProdutora.Text = "";
                    txtDescricao.Text = "";
                    txtCategoria.Text = "";
                    txtLancamento.Text = "";
                    txtNotaFilme.Text = "";

                    MessageBox.Show("Registro deletado com sucesso!");
                    CON.Close();
                }

                catch (Exception ex)
                {
                    MessageBox.Show("Operação não realizado!" + ex);
                }

            }

        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                /*Conexão com o BD e buscando na tabela usuario*/
                MySqlConnection CON = new MySqlConnection("SERVER=localhost;PORT=3306;User ID=root;DATABASE=projetolocadora;PASSWORD=;");
                CON.Open();
                MySqlCommand CM = new MySqlCommand("SELECT Titulo, Produtora, Descricao, NotaFilme, DataLancamento, Categoria FROM filme WHERE Id_Filme = ?", CON);
                CM.Parameters.Add("Id_Filme", MySqlDbType.Int32).Value = txtIDFilme.Text;

                //executa o comando
                CM.CommandType = CommandType.Text;
                //recebe o conteúdo que vem do banco
                MySqlDataReader DR;
                DR = CM.ExecuteReader();
                //insere as informações recebidas do banco para os componentes do form
                DR.Read();
                txtTituloFilme.Text = DR.GetString(0);
                txtProdutora.Text = DR.GetString(1);
                txtDescricao.Text = DR.GetString(2);
                txtNotaFilme.Text = DR.GetString(3);
                txtLancamento.Text = DR.GetString(4);
                txtCategoria.Text = DR.GetString(5);
            }

            catch (Exception ex)
            {
                MessageBox.Show("ID não encontrado!");
            }
        }

        private void btnLimpar_Click(object sender, EventArgs e)
        {
            txtIDFilme.Text = "";
            txtTituloFilme.Text = "";
            txtProdutora.Text = "";
            txtDescricao.Text = "";
            txtCategoria.Text = "";
            txtLancamento.Text = "";
            txtNotaFilme.Text = "";
        }
    }
}
