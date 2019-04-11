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
    }
}
