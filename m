From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 22:34:15 -0300
Subject: [PATCH V2 4/4] clk: imx6ul: remove clks_init_on array
In-Reply-To: <1528074406-11735-4-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
 <1528074406-11735-4-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DsJHTGQuU7KksZ5ZFFXi6YkX=2Gz=aVqC3775tqHL_cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 3, 2018 at 10:06 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
>
> ARM clock is busy divider type which has the
> CLK_IS_CRITICAL flag set by default when registered.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
