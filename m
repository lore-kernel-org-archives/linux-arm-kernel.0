From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Aug 2012 14:01:14 -0700
Subject: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
In-Reply-To: <20120822191139.GI7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120822191139.GI7995@opensource.wolfsonmicro.com>
Message-ID: <20120822210114.GL11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120822 12:12]:
> On Thu, Aug 16, 2012 at 04:41:01PM +0300, Peter Ujfalusi wrote:
> > On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> > the FIFO for the audio stack.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> I applied this - Tony, from the thread it seemed you were OK even though
> you didn't explicitly ack it?

Ah yes sorry, I'm fine with it. Sounds like you already applied it,
so too late to ack. But just in case:

Acked-by: Tony Lindgren <tony@atomide.com>
