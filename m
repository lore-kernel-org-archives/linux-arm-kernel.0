From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 23:44:33 +0800
Subject: [PATCH] ARM: mxc: Include missing irqs.h header
In-Reply-To: <20120728111422.GD2128@S2101-09.ap.freescale.net>
References: <1343029278-11654-1-git-send-email-festevam@gmail.com>
 <20120728111422.GD2128@S2101-09.ap.freescale.net>
Message-ID: <20120728154431.GM2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 07:14:24PM +0800, Shawn Guo wrote:
> On Mon, Jul 23, 2012 at 04:41:18AM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Include irqs.h in order to fix the following build error:
> > 
> > arch/arm/plat-mxc/tzic.c:195:11: error: 'FIQ_START' undeclared (first use in this function)
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Thanks for the patch.  Will send it to arm-soc shortly.
> 
Olof,

I just noticed you had sent the first batch fixes for merge window
fallout.  Unfortunately, this is another one.  Will there be a second
batch fixes targeting -rc1?  If so, please help pick up this one,
otherwise, I will queue it for later -rc.

-- 
Regards,
Shawn
