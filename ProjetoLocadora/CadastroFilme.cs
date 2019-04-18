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
    }
}
