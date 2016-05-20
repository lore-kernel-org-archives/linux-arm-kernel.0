From: ping.bai@nxp.com (Ping Bai)
Date: Fri, 20 May 2016 02:25:18 +0000
Subject: mx6ul cannot reboot
In-Reply-To: <CAOMZO5CF7g=GOXL_BMRQTZ6UPk+15z3hkxoM3j+KW033Dtp7wA@mail.gmail.com>
References: <CAOMZO5DLz7vBARB+uweDG+tw0UM3EMDb9+_XcLaaBv0GN+im7g@mail.gmail.com>
 <CAOMZO5CF7g=GOXL_BMRQTZ6UPk+15z3hkxoM3j+KW033Dtp7wA@mail.gmail.com>
Message-ID: <DB4PR04MB538C503553C02CE7DDA5385874B0@DB4PR04MB538.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

I have already add cpufreq driver support in imx6q-cpufreq.c before adding the cpufreq device.
Commit: a35fc5a33b62a6c658b8ffe7544c966c1776d128.

BR
Jacky Bai

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2016?5?20? 10:11
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>; Yongcai Huang
> <anson.huang@nxp.com>; Frank Li <frank.li@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Ping Bai <ping.bai@nxp.com>
> Subject: Re: mx6ul cannot reboot
> 
> On Wed, May 11, 2016 at 6:12 PM, Fabio Estevam <festevam@gmail.com>
> wrote:
> > Hi,
> >
> > After issuing a 'reboot' command on mx6ul-evk running 4.6-rc I get the
> > following problem:
> 
> ....
> 
> > I have only seen this on mx6ul.
> 
> The cpufreq-imx6q driver does not support mx6ul yet, so in order to fix this
> issue I had to revert 7f7308198f98700be ("ARM: imx: add cpufreq device for
> imx6ul"). Just sent a patch with the revert.
