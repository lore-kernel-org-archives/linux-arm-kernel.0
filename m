From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Mon, 2 Nov 2009 18:21:48 +0100
Subject: [RFC PATCH 00/10] PCMCIA soc_common re-factorization
In-Reply-To: <20091029172552.GB11460@n2100.arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
	<20091027231849.GE22412@n2100.arm.linux.org.uk>
	<20091028212534.GA31361@comet.dominikbrodowski.net>
	<20091029172552.GB11460@n2100.arm.linux.org.uk>
Message-ID: <20091102172148.GA11782@isilmar.linta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2009 at 05:25:52PM +0000, Russell King - ARM Linux wrote:
> On Wed, Oct 28, 2009 at 10:25:34PM +0100, Dominik Brodowski wrote:
> > Do you have a git tree to pull from, or shall I apply each patch locally?
> > Alternatively, you're free to push it upstream yourself; as the PCMCIA core
> > is only touched in one (albeit _very_ useful) line.
> 
> Thanks.  Here's a URL you can pull them from:
> 
> ssh://master.kernel.org/home/rmk/linux-2.6-arm.git pcmcia

Thanks! I've applied the patches you sent me by mail, though, as your tree
was based on something more recent from Linus than my tree, and I wanted to
avoid a merge of Linus' tree into my tree.

http://git.kernel.org/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=summary
should have your patches momentarily.

Best,
	Dominik
