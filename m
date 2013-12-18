From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Dec 2013 19:32:41 +0800
Subject: imx6 power consumption
In-Reply-To: <E1VtF3I-0002MQ-Ra@merlin.infradead.org>
References: <E1VszO5-00060R-Gp@merlin.infradead.org>
 <20131218024546.GA6691@S2101-09.ap.freescale.net>
 <E1VtF3I-0002MQ-Ra@merlin.infradead.org>
Message-ID: <20131218113240.GK6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:12:05PM +0100, Bj?rn Erik Nilsen wrote:
> As far as I can tell, commit e95dddb34c8 "ARM: imx: enable anatop
> suspend/resume" is the common ancestor for mainline and freescale, and
> from there pm-imx6q.c starts to diverge.
> 
> I haven not looked at it in great detail yet, but it seems there are not
> too many patches missing in mainline. Any idea why remaining patches
> haven't been upstreamed?

Probably because no one cares and would spend time to upstream these
patches.

Shawn

> 
> If it is just a matter of someone doing the work, what would be the
> recommended approach?
> 
> 
> Best regards,
> Bj?rn Erik Nilsen
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
