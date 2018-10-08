From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 8 Oct 2018 10:45:33 +0000
Subject: [PATCH V4 0/2] soc: imx: add scu power domain driver
In-Reply-To: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM0PR04MB421164390B8F71165532E50E80E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Would you take this as well?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Sunday, October 7, 2018 9:10 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: dongas86 at gmail.com; kernel at pengutronix.de; shawnguo at kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> rjw at rjwysocki.net; ulf.hansson at linaro.org; khilman at kernel.org;
> linux-pm at vger.kernel.org; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V4 0/2] soc: imx: add scu power domain driver
> 
> This patch set adds the scu based power domain driver.
> It depends on SCU driver.
> 
> Change Log:
> v3->v4:
>  * only scu headfile path update
> 
> v2->v3:
>  * structure and enums name update
>  * api usage update
> 
> Dong Aisheng (2):
>   firmware: imx: add pm svc headfile
>   firmware: imx: add SCU power domain driver
> 
>  drivers/firmware/imx/Kconfig        |   6 ++
>  drivers/firmware/imx/Makefile       |   3 +-
>  drivers/firmware/imx/scu-pd.c       | 167
> ++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h    |   1 +
>  include/linux/firmware/imx/svc/pm.h |  85 ++++++++++++++++++
>  5 files changed, 261 insertions(+), 1 deletion(-)  create mode 100644
> drivers/firmware/imx/scu-pd.c  create mode 100644
> include/linux/firmware/imx/svc/pm.h
> 
> --
> 2.7.4
