From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 31 May 2010 15:13:17 +0200
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <20100531124750.GA21679@n2100.arm.linux.org.uk>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
	<20100531124750.GA21679@n2100.arm.linux.org.uk>
Message-ID: <20100531131317.GF2698@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 01:47:50PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 31, 2010 at 01:48:16PM +0200, Daniel Mack wrote:
> > Hi Eric,
> > 
> > Is there any plans to merge Linus' tree into your pxa-devel any time
> > soon? I'm asking because I have one patch pending which depends on
> > 
> >   a3bcbbee ("pda_power: Add function callbacks for suspend and resume")
> > 
> > upstream. Alternatively, could you cherry-pick this one commit?
> 
> Please don't cherry-pick commits back into branches which will eventually
> find their way back into mainline.

Hmm, ok just wait for the back-merge then. It's just that one single
commit and not an urgent fix.

Just out of interest - why would cherry-picking be frowned upon?
Shouldn't git just ignore the commits it already knows when things are
pulled?

Thanks,
Daniel
