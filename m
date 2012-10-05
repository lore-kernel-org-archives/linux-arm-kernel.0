From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Oct 2012 11:09:22 -0700
Subject: [PATCH 09/16] ARM: OMAP: Split plat/mmc.h into local headers
 and platform_data
In-Reply-To: <CAOyx1LpfdM1_BE23-GVvGAcNAHos694J-Ob1cHNkLid31O-sSw@mail.gmail.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220454.26676.10131.stgit@muffinssi.local>
 <CAOyx1LpfdM1_BE23-GVvGAcNAHos694J-Ob1cHNkLid31O-sSw@mail.gmail.com>
Message-ID: <20121005180922.GO3874@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Venkatraman S <svenkatr@ti.com> [121004 23:40]:
> On Fri, Oct 5, 2012 at 3:34 AM, Tony Lindgren <tony@atomide.com> wrote:
> > We need to remove this from plat for ARM common zImage
> > support.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Venkatraman S <svenkatr@ti.com>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks Tony. I suppose this should go into your tree..
> Acked-by: Venkatraman S <svenkatr@ti.com>

Thanks yeah it's probably best that I set up some
minimal immutable branch that Chris can also pull
in assuming these two MMC patches look OK.

Regards,

Tony
