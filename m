From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 08:44:17 +0000
Subject: [PATCH v9 10/13] ARM: SoC: convert imx6q to SoC descriptor
In-Reply-To: <20120913011742.GB2725@S2101-09.ap.freescale.net>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
 <1347461906-13527-11-git-send-email-arnd@arndb.de>
 <20120913011742.GB2725@S2101-09.ap.freescale.net>
Message-ID: <201209130844.18667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Shawn Guo wrote:
> >  
> >  DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
> > +     .smp            = smp_ops(imx6q_soc_desc),
> 
> s/imx6q_soc_desc/imx_smp_ops

Yes, just noticed this myself when testing the series together with other patches.

> Otherwise,
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks,

	Arnd
