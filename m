From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 23:17:52 -0300
Subject: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BZsmY=_+H7vMomoY+pUx0fY2kh80rgx6UVMUYWct9ojQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 9:58 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, and its clock gate in CCM CCGR1 CG14
> needs to be enabled before access, add it to
> clock tree.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
