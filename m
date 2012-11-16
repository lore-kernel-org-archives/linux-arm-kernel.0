From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 14:54:19 +0800
Subject: [PATCH 01/10] ARM: imx6q: print silicon version on boot
In-Reply-To: <50A5DC5A.3040603@gmail.com>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-2-git-send-email-shawn.guo@linaro.org>
 <72B629D8-8CD8-42E2-91A3-CF0532B15E5F@mentor.com>
 <20121116022346.GA2941@S2100-06.ap.freescale.net>
 <50A5DC5A.3040603@gmail.com>
Message-ID: <20121116065417.GC2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 07:25:30AM +0100, Dirk Behme wrote:
> Just a small note on the whole series:
> 
> We picked the two patches
> 
> ARM: imx6q: print silicon version on boot
> ARM: imx6q: select ARM and PL310 errata
> 
> because they look generic and generally useful. Not only for the
> cpuidle feature.
> 
> Maybe it makes sense to apply these two patches independent from the
> cpuidle series as general improvements?
> 
Ok, will send both patch for 3.8.

Shawn
