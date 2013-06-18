From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Jun 2013 16:41:48 +0900
Subject: [PATCH 1/2] ARM: shmobile: irqpin: add a DT property to enable
 masking on parent
In-Reply-To: <20130612083850.GF6006@verge.net.au>
References: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
 <CANqRtoTqHiRixV571CrMkc=ijWcrfZFzaSrfjN1SKRNTgTTcZA@mail.gmail.com>
 <20130612083850.GF6006@verge.net.au>
Message-ID: <20130618074146.GG24960@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 05:38:50PM +0900, Simon Horman wrote:
> On Tue, Jun 11, 2013 at 06:37:24PM +0900, Magnus Damm wrote:
> > On Fri, May 24, 2013 at 6:13 PM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > > To disable spurious interrupts, that get triggered on certain hardware, the
> > > irqpin driver masks them on the parent interrupt controller. To specify
> > > such broken devices a .control_parent parameter can be provided in the
> > > platform data. In the DT case we need a property, to do the same.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >
> > > These two patches simply split the earlier "ARM: shmobile: irqpin: fix
> > > handling of spurious interrupts in DT case" patch into two parts.
> > > Otherwise no change.
> > 
> > I'm fine with this portion of the patch series. Thanks for your help!
> >
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> I believe that this patch depends on
> "irqchip: renesas-intc-irqpin: DT binding for sense bitfield width"
> which Arnd has requested some modifications to.
> 
> "I think you should add documentation here about how the two interrupt
> cells are to be interpreted, to allow people to fill the values from a data
> sheet or board schematic."
> http://www.spinics.net/lists/linux-sh/msg20202.html
> 
> Please post a fresh series that:
> 
> 1. Includes a fresh version of "irqchip: renesas-intc-irqpin: DT binding
>    for sense bitfield width" with Arnd's concerns addressed.
> 
> 2. Includes this patch with Magnus's Ack.
> 
> Please be sure to CC Arnd on the new series.

Hi Guennadi,

I see that you reposted "irqchip: renesas-intc-irqpin: DT binding
for sense bitfield width", which I have queued-up, without this patch.

Please rebase this patch and repost it with Magnus's Ack.
