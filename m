From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Oct 2012 12:03:32 -0700
Subject: [PATCH 08/16] ARM: OMAP2: Move plat/menelaus.h to
 linux/mfd/menelaus.h
In-Reply-To: <20121025111158.GA5297@sortiz-mobl>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220451.26676.62349.stgit@muffinssi.local>
 <20121025111158.GA5297@sortiz-mobl>
Message-ID: <20121025190332.GX11928@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Samuel Ortiz <sameo@linux.intel.com> [121025 04:14]:
> Hi Tony,
> 
> On Thu, Oct 04, 2012 at 03:04:52PM -0700, Tony Lindgren wrote:
> > We can move menelaus.h to live with other mfd headers to
> > get it out of plat for ARM common zImage support.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Thanks, I've now pushed a branch with this patch only
to omap-for-v3.8/cleanup-headers-menelaus branch in case
you need to merge it in too.

Regards,

Tony
