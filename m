From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 31 Mar 2015 18:40:11 +0100
Subject: [PATCH v2 6/6] MAINTAINERS: Add phy-miphy28lp.c to ARCH/STI
 architecture
In-Reply-To: <551AC831.2000108@ti.com>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
 <1427728632-10846-7-git-send-email-peter.griffin@linaro.org>
 <551AC831.2000108@ti.com>
Message-ID: <20150331174011.GA16741@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Tue, 31 Mar 2015, Kishon Vijay Abraham I wrote:
<snip>

> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 1de6afa..fa1bb4f 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -1469,6 +1469,7 @@ F:	drivers/clocksource/arm_global_timer.c
> >  F:	drivers/i2c/busses/i2c-st.c
> >  F:	drivers/media/rc/st_rc.c
> >  F:	drivers/mmc/host/sdhci-st.c
> >+F:	drivers/phy/phy-miphy28lp.c
> 
> add for miphy365x.c as well?

Yes we should also be adding miphy365x.c as well.

Would you like me to send a seperate patch for that?

regards,

Peter.
