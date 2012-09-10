From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Sep 2012 01:39:13 +0100
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <20120910002020.GB16249@opensource.wolfsonmicro.com>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
 <20120909235059.GA2643@sirena.org.uk>
 <20120910001524.GL13739@n2100.arm.linux.org.uk>
 <20120910002020.GB16249@opensource.wolfsonmicro.com>
Message-ID: <20120910003913.GM13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 08:20:21AM +0800, Mark Brown wrote:
> On Mon, Sep 10, 2012 at 01:15:24AM +0100, Russell King - ARM Linux wrote:
> > Note that the patch system doesn't always return error messages anymore
> > (it used to do that reliably, but as it's now a favourite target for
> > spammers and was creating soo much backscatter, which was then filling
> > my mailbox with bounces... that had to change.)
> 
> Hrm, that's not ideal.  It'd be nice if it were able to do something
> like always reply if there were patch contents, or if it found things
> like the KernelVersion line in there.  Obviously e-mail is also not time
> guaranteed so deciding it's not responded (and then working out why it
> did that) is going to be unreliable too.

It tries to - if it finds what it thinks is a patch in the right place
in the email.  If it doesn't think it found a patch then it won't reply.
In other words, if you include a patch without a PATCH FOLLOWS or the ---
commit message/diffstat break marker preceding it, it will ignore you.

> I do recall seeing the patch in the database but it's not showing up any
> more so perhaps I was thinking of a different patch.

Well, no patch ever gets deleted from the database... the only way even I
can do that is to manually issue the SQL.

> OK, that's what I'd thought was going on - it was the fact that you'd
> just acked the patch rather than asked for it to go to the patch tracker
> or something which made me wonder if things had changed.

I kind'a forgot because it's been soo long since I took any of those
patches...
