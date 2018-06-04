From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jun 2018 22:33:22 -0300
Subject: [PATCH V2 2/4] clk: imx6sl: remove clks_init_on array
In-Reply-To: <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
 <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BU-4O0K0z-ZiL7N9bCceQVeytsGT=5RvD=jRWZ0QfWmA@mail.gmail.com>
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
> IPG clock has no clock gate and its parent AHB clock
> is busy divider type, so no need to add CLK_IS_CRITICAL
> flag for IPG clock.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
