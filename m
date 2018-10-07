From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 7 Oct 2018 12:36:51 +0000
Subject: [PATCH V8 0/3] soc: imx: add scu firmware api support
In-Reply-To: <20180930132759.GP26692@dragon>
References: <1538268516-24678-1-git-send-email-aisheng.dong@nxp.com>
 <20180930072628.GN26692@dragon> <20180930132759.GP26692@dragon>
Message-ID: <AM0PR04MB421150896A65871B0D3AD4E480E50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
> > >  drivers/firmware/Kconfig                           |   1 +
> > >  drivers/firmware/Makefile                          |   1 +
> > >  drivers/firmware/imx/Kconfig                       |  11 +
> > >  drivers/firmware/imx/Makefile                      |   2 +
> > >  drivers/firmware/imx/imx-scu.c                     | 270
> +++++++++
> > >  drivers/firmware/imx/misc.c                        |  99 ++++
> > >  include/soc/imx/scu/ipc.h                          |  59 ++
> > >  include/soc/imx/scu/sci.h                          |  17 +
> > >  include/soc/imx/scu/svc/misc.h                     |  55 ++
> > >  include/soc/imx/scu/types.h                        | 617
> +++++++++++++++++++++
> 
> ... I'm not sure the scu folder should be created under include/soc/imx/ or
> include/linux/firmware/imx/ like meson platform.  I would like to hear more
> opinions.
> 

I guess include/Linux/firmware/imx would be better.
I will resend a patch series with this updated.
If any issue please let me know.

Regards
Dong Aisheng

> Shawn
