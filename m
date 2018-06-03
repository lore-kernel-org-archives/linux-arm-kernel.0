From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 17:57:19 -0300
Subject: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BiAHjrMQnwuOFR7XMcpQpi=WXO=Uh=mZO1vDLNoJdGzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 2, 2018 at 11:33 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Some platforms like i.MX6UL/i.MX6SLL have L2
> page power control in GPC, it needs to be
> disabled if ARM is power gated and L2 is NOT
> flushed, add GPC interface to control it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
