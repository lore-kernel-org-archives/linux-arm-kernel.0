From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:31:45 -0700
Subject: [PATCH V4 02/11] clk: imx: scu: add scu clock common part
In-Reply-To: <1539504194-28289-3-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972550584.5275.12112973418888551824@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-14 01:07:45)
> Add scu clock common part which will be used by client clock drivers.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3->v4:
>  * scu headfile path change
> v2->v3:
>  * no changes
> v1->v2:
>  * update function call name
> ---
>  drivers/clk/imx/Kconfig       |  2 ++
>  drivers/clk/imx/Makefile      |  2 ++
>  drivers/clk/imx/scu/Kconfig   |  5 +++++
>  drivers/clk/imx/scu/Makefile  |  4 ++++
>  drivers/clk/imx/scu/clk-scu.c | 17 +++++++++++++++++
>  drivers/clk/imx/scu/clk-scu.h | 18 ++++++++++++++++++

Why is scu nested one level deeper in the imx directory? Can't we just
keep them all within imx toplevel directory?

>  6 files changed, 48 insertions(+)
>  create mode 100644 drivers/clk/imx/scu/Kconfig
>  create mode 100644 drivers/clk/imx/scu/Makefile
>  create mode 100644 drivers/clk/imx/scu/clk-scu.c
>  create mode 100644 drivers/clk/imx/scu/clk-scu.h
> 
