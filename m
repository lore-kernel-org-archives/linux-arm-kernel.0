From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 7 May 2012 11:20:52 +0800
Subject: [PATCH v2 1/5] dma: mxs-dma: use global stmp_device functionality
In-Reply-To: <20120504144453.GM2194@S2101-09.ap.freescale.net>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
 <20120504144453.GM2194@S2101-09.ap.freescale.net>
Message-ID: <20120507032051.GA31245@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 10:44:56PM +0800, Shawn Guo wrote:
> On Fri, May 04, 2012 at 08:12:15PM +0800, Dong Aisheng wrote:
> >  #include <asm/irq.h>
> > -#include <mach/mxs.h>
> 
> I do not think you can remove this inclusion in this patch, since the
> use of cpu_is_mx23() does not get removed from mxs-dma driver until
> patch #2.
> 
Yes. I missed somehow.

> You do not have to resend the series, if there are no other outstanding
> comments coming up.  I expect the series will go through arm-soc tree
> to ease the merging.  I can fix it when applying the series.
> 
Thanks.

Regards
Dong Aisheng

> Hi Vinod,
> 
> Please let me know if you have problem with the series going through
> arm-soc than dma tree.  Thanks.
> 
> > -#include <mach/common.h>
> 
> -- 
> Regards,
> Shawn
> 
