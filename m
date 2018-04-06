From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:20:40 -0700
Subject: [RESEND 4/4] clk: imx7d: Move clks_init_on before any clock
 operations
In-Reply-To: <1522219599-10831-6-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303884033.143116.14807011107162910724@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-03-27 23:46:39)
> From: Dong Aisheng <b29396@freescale.com>
> 
> For init on clocks we should move it at the first place in imx7d_clocks_init()
> before any clock operations, else the clock operation may fail in case the clock
> is still not on.
> 
> Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
