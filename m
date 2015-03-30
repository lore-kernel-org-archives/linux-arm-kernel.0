From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Mar 2015 14:30:08 +0200
Subject: [PATCH 0/3] Add DT support for netxbig LEDs
In-Reply-To: <20150330083040.GY1509@kw.sim.vm.gnt>
References: <1424703861-20903-1-git-send-email-simon.guinot@sequanux.org>
 <20150309094107.GL1509@kw.sim.vm.gnt>
 <5506FE46.4000405@free-electrons.com>
 <20150330083040.GY1509@kw.sim.vm.gnt>
Message-ID: <20150330123008.GC17650@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:30:40AM +0200, Simon Guinot wrote:
> On Mon, Mar 16, 2015 at 05:01:10PM +0100, Gregory CLEMENT wrote:
> > Hi all,
> > 
> > On 09/03/2015 10:41, Simon Guinot wrote:
> > > On Mon, Feb 23, 2015 at 04:04:18PM +0100, Simon Guinot wrote:
> > >> Hello,
> > >>
> > >> This patch series adds DT support for the LEDs found on the Kirkwood-based
> > >> LaCie boards 2Big and 5Big Network v2.
> > >>
> > >> Simon
> > >>
> > >> Simon Guinot (3):
> > >>   leds: netxbig: add device tree binding
> > >>   ARM: Kirkwood: add LED DT entries for netxbig boards
> > >>   ARM: mvebu: remove static LED setup for netxbig boards
> > > 
> > > Hi Brian,
> > > 
> > > Please, consider merging the first patch of this serie.
> > 
> > Brian,
> > 
> > here again let me know when this patch will be merged, and I will
> > also need a stable tag as patch 2 depends on this one.
> > 
> > Andrew, Jason,
> > 
> > patch 2 and 3 looks OK for me. What is your opinion about it?
> 
> Hi Gregory, Andrew and Jason,
> 
> This patch set seems stuck. I believe that Bryan is probably too busy to
> handle it...
> 
> Is that possible to merge it via the mvebu tree ? Since only some LaCie
> boards are impacted, I think it could make sense.

Hi Simon

Hard one. I also have a driver stuck in led limbo.

Last time we took a fix via mvebu, it all went messy at the last
minute. We made it very clear to Bryon we planned to take a patch via
mvebu, we had queued it via mvebu, we had sent a pull request to
arm-soc, all with no reply from Bryon. Only at the last minute did he
jump in, pull it himself and send it to Linus. That caused Olof all
sorts of problems with his tree.

To stop that happening again, i think we need an Acked-by from Bryan.

   Andrew
