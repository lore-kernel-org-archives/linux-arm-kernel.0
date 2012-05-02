From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 21:53:59 +0800
Subject: [PATCH v2 3/3] ARM: imx: Add imx6q cpuidle driver
In-Reply-To: <CAMXH7KHnN3YDwM6crgaFqwrgb4W=CErjgNiTPaZ8wrZ5dvKLuw@mail.gmail.com>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-4-git-send-email-rob.lee@linaro.org>
 <20120502032336.GU2194@S2101-09.ap.freescale.net>
 <CAMXH7KHnN3YDwM6crgaFqwrgb4W=CErjgNiTPaZ8wrZ5dvKLuw@mail.gmail.com>
Message-ID: <20120502135357.GC2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 08:50:20AM -0500, Rob Lee wrote:
> >> --- a/arch/arm/mach-imx/mach-imx6q.c
> >> +++ b/arch/arm/mach-imx/mach-imx6q.c
> >> @@ -21,6 +21,9 @@
> >> ?#include <linux/of_platform.h>
> >> ?#include <linux/phy.h>
> >> ?#include <linux/micrel_phy.h>
> >> +#include <linux/export.h>
> >> +#include <linux/cpuidle.h>
> >> +#include <asm/cpuidle.h>
> >> ?#include <asm/smp_twd.h>
> >> ?#include <asm/hardware/cache-l2x0.h>
> >> ?#include <asm/hardware/gic.h>
> >> @@ -29,6 +32,7 @@
> >> ?#include <asm/system_misc.h>
> >> ?#include <mach/common.h>
> >> ?#include <mach/hardware.h>
> >> +#include <mach/cpuidle.h>
> >
> > The headers here are mostly sorted in names, so please ...
> >
> 
> Do you mean sorted alphabetically per group?  So the last three
> includes should look like this instead?
> ...
> #include <mach/common.h>
> #include <mach/cpuidle.h>
> #include <mach/hardware.h>
> ...

Yes.  And do not forget <linux/export.h> and <linux/cpuidle.h>.

-- 
Regards,
Shawn
