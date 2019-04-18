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
    public partial class TelaLogin : Form
    {
        public TelaLogin()
        {
            InitializeComponent();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void btnSair_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnEntrar_Click(object sender, EventArgs e)
        {
            string usuario, senha;
            usuario = txtUsuario.Text;
            senha = txtSenha.Text;
            if (usuario == "" && senha == "")
            {
                TelaInicial telaInicial = new TelaInicial();
                telaInicial.Show();
                this.Visible = false;
            }
            else
            { MessageBox.Show("Entre com um usuário e senha", "Alerta", MessageBoxButtons.OK, MessageBoxIcon.Exclamation); }

        }
    }
}
