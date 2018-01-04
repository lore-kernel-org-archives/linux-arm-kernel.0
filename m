From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Jan 2018 11:00:58 -0200
Subject: [PATCH 1/2] clk: imx: imx7d: add the snvs clock
In-Reply-To: <1515078402-22135-1-git-send-email-Anson.Huang@nxp.com>
References: <1515078402-22135-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DLXhScM71qHaeMoB5dW_0MeexjHaERxYoam0LBhiTD5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 1:06 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> According to the i.MX7D Reference Manual,
> SNVS block has a clock gate, accessing SNVS block
> would need this clock gate to be enabled, add it
> into clock tree so that SNVS module driver can
> operate this clock gate.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
