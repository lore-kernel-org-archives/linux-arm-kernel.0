From: pza@pengutronix.de (Philipp Zabel)
Date: Sat, 1 Feb 2014 22:51:40 +0100
Subject: [PATCH v7 0/7] ARM: rockchip: add smp functionality
In-Reply-To: <13010296.nzTT2PqdSR@phil>
References: <4970034.fqvMoHdOyd@phil>
 <13010296.nzTT2PqdSR@phil>
Message-ID: <20140201215140.GA1375@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Fri, Jan 31, 2014 at 11:03:03PM +0100, Heiko St?bner wrote:
> On Monday, 20. January 2014 16:41:43 Heiko St?bner wrote:
> > This series enables the use of the additional cores on Rockchip
> > Cortex-A9 SoCs.
> 
> So, two weeks without any general complaints, but I guess part of the more 
> general patches could use an ack.
> 
> Going forward, what would be best way to merge them?
> As one pull request to arm-soc, or for example splitting them into the first 
> three patches going through the misc tree and the rockchip specific stuff going 
> through arm-soc? Or something else altogether?
> 
> 
> > Heiko Stuebner (7):
> >   of: add functions to count number of elements in a property
> 
> One of the intermediate versions of this patch got a
> 	Reviewed-by: Mark Rutland <mark.rutland@arm.com> .
> Mark, is this still true for this variant addressing some additional wished 
> from Rob?
> 
> And this final version got a "Looks good" from Rob Herring in the original 
> thread, but a more formal "ack" might be nice :-) .
> 
> 
> >   dt-bindings: sram: describe option to reserve parts of the memory
> >   misc: sram: implement mmio-sram-reserved option
> 
> Philipp, you acked an intermediate version, and this v7 now should also 
> contain the two separate loops (1st gathering data and 2nd creating the pool 
> parts) you asked for.
> 
> Could I persuade you to take a look again?

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
