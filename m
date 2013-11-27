From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 11:20:09 +0100
Subject: [PATCH RFC v2 07/17] ARM: shmobile: r8a7779: Sort headers
 alphabetically
In-Reply-To: <20131127050958.GE27704@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <52946AEA.2010500@cogentembedded.com> <20131127050958.GE27704@verge.net.au>
Message-ID: <1615505.ZFJ3Lvc46h@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wednesday 27 November 2013 14:09:58 Simon Horman wrote:
> On Tue, Nov 26, 2013 at 01:33:30PM +0400, Sergei Shtylyov wrote:
> > On 26-11-2013 11:32, Simon Horman wrote:
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >---
> > >
> > >  arch/arm/mach-shmobile/board-marzen.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > >
> > >diff --git a/arch/arm/mach-shmobile/board-marzen.c
> > >b/arch/arm/mach-shmobile/board-marzen.c index 4f9e3ec..e202c64 100644
> > >--- a/arch/arm/mach-shmobile/board-marzen.c
> > >+++ b/arch/arm/mach-shmobile/board-marzen.c
> > >@@ -19,35 +19,35 @@
> > >   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 
> > >   02110-1301  USA */
> > >
> > >-#include <linux/kernel.h>
> > >+#include <asm/mach-types.h>
> > >+#include <asm/mach/arch.h>
> > >+#include <asm/traps.h>
> > >+#include <linux/delay.h>
> > >+#include <linux/dma-mapping.h>
> > > #include <linux/init.h>
> > > #include <linux/interrupt.h>
> > >-#include <linux/irq.h>
> > >-#include <linux/platform_device.h>
> > >-#include <linux/delay.h>
> > > #include <linux/io.h>
> > >+#include <linux/irq.h>
> > >+#include <linux/kernel.h>
> > > #include <linux/leds.h>
> > >-#include <linux/dma-mapping.h>
> > >+#include <linux/mfd/tmio.h>
> > >+#include <linux/mmc/host.h>
> > >+#include <linux/mmc/sh_mobile_sdhi.h>
> > > #include <linux/pinctrl/machine.h>
> > > #include <linux/platform_data/camera-rcar.h>
> > > #include <linux/platform_data/gpio-rcar.h>
> > > #include <linux/platform_data/rcar-du.h>
> > > #include <linux/platform_data/usb-rcar-phy.h>
> > >+#include <linux/platform_device.h>
> > > #include <linux/regulator/fixed.h>
> > > #include <linux/regulator/machine.h>
> > > #include <linux/smsc911x.h>
> > >-#include <linux/spi/spi.h>
> > > #include <linux/spi/sh_hspi.h>
> > >-#include <linux/mmc/host.h>
> > >-#include <linux/mmc/sh_mobile_sdhi.h>
> > >-#include <linux/mfd/tmio.h>
> > >-#include <media/soc_camera.h>
> > >-#include <mach/r8a7779.h>
> > >+#include <linux/spi/spi.h>
> > > #include <mach/common.h>
> > > #include <mach/irqs.h>
> > >-#include <asm/mach-types.h>
> > >-#include <asm/mach/arch.h>
> > >-#include <asm/traps.h>
> > >+#include <mach/r8a7779.h>
> > >+#include <media/soc_camera.h>
> > >
> >    I thought it was a good idea to keep the #include's in the order
> > 
> > of the most generic to most machine specific ones: <linux/*.h>
> > first, then <asm/*.h>, then <mach/*.h>, only with empty lines
> > between groups (which weren't used here) with each group kept
> > sorted...
> 
> That sounds reasonable to me.
> Laurent, do you have an opinion on this?

That's fine with me.

-- 
Regards,

Laurent Pinchart
