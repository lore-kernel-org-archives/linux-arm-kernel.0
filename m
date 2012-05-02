From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 13:21:26 +0800
Subject: [PATCH v2 1/3] mtd: gpmi: add device tree support for mx6q and
 mx28
In-Reply-To: <4FA0A0ED.7070804@freescale.com>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
 <1335323184-11233-2-git-send-email-b32955@freescale.com>
 <20120501074943.GB2194@S2101-09.ap.freescale.net>
 <4FA0A0ED.7070804@freescale.com>
Message-ID: <20120502052124.GX2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 10:50:21AM +0800, Huang Shijie wrote:
> Hi Shawn:
> 
> thanks a lot for your review.
> >You are adding device tree support into a driver that is working fine
> >for non-DT probe.  So before all the users of this driver are converted
> >to DT, you have to ensure the driver works for both non-DT and DT users
> >in a single image when you add DT support for it.
> The current gpmi-nand driver can not work in the non-DT, as you
> known, there are
> several patches which are not accepted to you.
> 
> So, does it make sense to still maintain the support for non-DT?
> 
> So i prefer to convert the gpmi-nand to a pure DT driver. make the
> code clear and simple.
> 
Yeah, I'm fine with that.

-- 
Regards,
Shawn
