From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Jun 2017 15:38:56 -0300
Subject: [PATCH v2 2/2] ARM: imx6ull: Make suspend/resume work like on 6ul
In-Reply-To: <7dcc71ab09d8d459de1826e55516349b1a2bda33.1496771145.git.leonard.crestez@nxp.com>
References: <cover.1496771145.git.leonard.crestez@nxp.com>
 <7dcc71ab09d8d459de1826e55516349b1a2bda33.1496771145.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5DZt73W4g9wx14KB-uDBhPKeEckbgMVu6aGE+rGJZsLkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 2:50 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> Suspend and resume on imx6ull is currenty not working because of some
> missed checks where behavior should match imx6ul.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
