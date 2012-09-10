From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Sep 2012 08:20:21 +0800
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <20120910001524.GL13739@n2100.arm.linux.org.uk>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
 <20120909235059.GA2643@sirena.org.uk>
 <20120910001524.GL13739@n2100.arm.linux.org.uk>
Message-ID: <20120910002020.GB16249@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 01:15:24AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 10, 2012 at 12:50:59AM +0100, Mark Brown wrote:

> > I posted a patch for this (clk: Move devm_ APIs out of clkdev into
> > HAVE_CLK) towards the end of the last release cycle and I think reposted
> > it since and it had been sent to the patch tracker too (though I can't
> > find any record of anything except the submission mail now).  It would
> > be *really* good to get this merged.

> Note that the patch system doesn't always return error messages anymore
> (it used to do that reliably, but as it's now a favourite target for
> spammers and was creating soo much backscatter, which was then filling
> my mailbox with bounces... that had to change.)

Hrm, that's not ideal.  It'd be nice if it were able to do something
like always reply if there were patch contents, or if it found things
like the KernelVersion line in there.  Obviously e-mail is also not time
guaranteed so deciding it's not responded (and then working out why it
did that) is going to be unreliable too.

I do recall seeing the patch in the database but it's not showing up any
more so perhaps I was thinking of a different patch.

> > Who's looking after clkdev these days?  Mike doesn't seem to take
> > patches as he's expecting Russell to take them which was happening for a
> > while but I'm not sure that's the case any more, especially given
> > Russell's followup here.  Due to the patch tracker the usual things for
> > following up on unapplied patches don't work terribly well, it's much
> > less likely that it's just an oversight there.

> Well, in theory I'm the maintainer for clkdev and clk API, so I should
> take the patch...

OK, that's what I'd thought was going on - it was the fact that you'd
just acked the patch rather than asked for it to go to the patch tracker
or something which made me wonder if things had changed.
