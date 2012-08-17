From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 06:10:24 -0700
Subject: [PATCH v3 0/9] ARM/ASoC: OMAP McBSP device tree support
In-Reply-To: <20120817101838.GB30548@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <20120817101838.GB30548@opensource.wolfsonmicro.com>
Message-ID: <20120817131023.GE11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120817 03:18]:
> On Thu, Aug 16, 2012 at 04:40:59PM +0300, Peter Ujfalusi wrote:
> 
> > in order to be able to add DT support for the McBSP driver which is used on all
> > OMAP platforms (OMAP1/2/3/4/5) I needed to make some cleanups to the stack:
> 
> Tony, are you OK with these changes going via ASoC?

Yes, had one 2420 related question about the FIFO, other than that
I've acked the omap related patches.

Tony
