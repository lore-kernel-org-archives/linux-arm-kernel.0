From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Nov 2015 06:54:53 -0800
Subject: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
In-Reply-To: <20151104164120.GO12910@localhost>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
 <87egg54td4.fsf@saruman.tx.rr.com>
 <20151104164120.GO12910@localhost>
Message-ID: <20151113145452.GD2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vinod Koul <vinod.koul@intel.com> [151104 08:38]:
> On Wed, Nov 04, 2015 at 10:33:27AM -0600, Felipe Balbi wrote:
> > Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> > 
> > > The eDMA3 TPTC does not need any software configuration, but it is a
> > > separate IP block in the SoC. In order the omap hwmod core to be able to
> > > handle the TPTC resources correctly in regards of PM we need to have a
> > > driver loaded for it.
> > > This patch will add a dummy driver skeleton without probe or remove
> > > callbacks provided.
> > >
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Reported-by: Olof Johansson <olof@lixom.net>
> > 
> > This fixes the problem I also reported on linux-omap [1]
> > 
> > Tested-by: Felipe Balbi <balbi@ti.com>
> > 
> > [1] http://marc.info/?l=linux-omap&m=144665429032014&w=2
> 
> Great, I was about to point you to this series, I will push this in -next
> now

Soungd good to me, thanks for fixing it up Peter.

Tony
