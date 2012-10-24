From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Oct 2012 14:49:24 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Introduce local usb.h
In-Reply-To: <20121019073803.GG12235@arwen.pp.htv.fi>
References: <20121019021816.6693.65985.stgit@muffinssi.local>
 <20121019022005.6693.98660.stgit@muffinssi.local>
 <20121019073803.GG12235@arwen.pp.htv.fi>
Message-ID: <20121024214924.GL5605@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [121019 00:45]:
> On Thu, Oct 18, 2012 at 07:20:05PM -0700, Tony Lindgren wrote:
> > Let's move what we can from plat/usb.h to the local usb.h
> > for ARM common zImage support.
> > 
> > This is needed so we can remove plat/usb.h for ARM common
> > zImage support.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks, I've now pushed these two patches on v3.7-rc1 to
omap-for-v3.8/cleanup-headers-usb branch.

Greg and Samuel, in case you need to, it's OK to merge the
branch above now that plat/usb.h is moved.

Regards,

Tony
