From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 19:28:05 +0800
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <4FE97BCC.7050904@pengutronix.de>
References: <1338084709-12043-1-git-send-email-marex@denx.de>
 <4FE97B12.8040306@pengutronix.de> <4FE97BCC.7050904@pengutronix.de>
Message-ID: <20120626112804.GC8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:07:24AM +0200, Marc Kleine-Budde wrote:
> > +       select HAVE_CAN_FLEXCAN if NET && CAN
> 
> ...and put this select to MACH_MXS_DT, instead of SOC_IMX28
> 
Hmm, why?  Flexcan is a feature/block of SoC rather than a machine,
isn't it?

-- 
Regards,
Shawn
