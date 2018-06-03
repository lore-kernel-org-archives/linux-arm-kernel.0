From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 17:58:13 -0300
Subject: [PATCH V2 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
 idle driver
In-Reply-To: <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
 <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5CjOyy-rohwfLS+TuWqTFVHExj=_R2_P-N7BTb_Kn5FuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 2, 2018 at 11:33 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL supports ARM power off in cpu idle, better to reuse
> i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
> support ARM power off.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
