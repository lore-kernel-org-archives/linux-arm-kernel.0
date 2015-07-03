From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 3 Jul 2015 22:24:33 +0200
Subject: [GIT PULL] remoteproc for 4.2
In-Reply-To: <5594F86B.1040801@melag.de>
References: <CAK=Wgba9Jst3xJ_EQf+zenZSqedzhvSw8ZVMZ_YmsQM70mMbPA@mail.gmail.com>
 <5594F86B.1040801@melag.de>
Message-ID: <20150703202433.GI21222@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 10:38:03AM +0200, Enrico Weigelt, metux IT consult wrote:
> >for you to fetch changes up to 8de3dbd0895bebe52d069a82feae8e3fb51c1bdf:
> >
> >   remoteproc: fix !CONFIG_OF build breakage (2015-06-18 11:44:41 +0300)
> 
> Just curious: could this rproc framework also be used for more specific
> coprocessors like the VPUs found on various SoCs ? (eg. CODA on imx53)

No. And there is already a driver in mainline that handles the VPU.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
