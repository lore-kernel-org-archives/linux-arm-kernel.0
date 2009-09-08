From: nico@cam.org (Nicolas Pitre)
Date: Tue, 08 Sep 2009 14:25:01 -0400 (EDT)
Subject: [GIT PULL] pxa: 1 fix for zaurus resume
In-Reply-To: <20090908102309.GC23361@n2100.arm.linux.org.uk>
References: <f17812d70909070909q556e6cbcu84d9dc14ccb8691b@mail.gmail.com>
	<20090908102309.GC23361@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0909081419360.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Sep 2009, Russell King - ARM Linux wrote:

> On Tue, Sep 08, 2009 at 12:09:58AM +0800, Eric Miao wrote:
> > This is a bit late, please consider this fix for zaurus resume in .31.
> 
> It's not late; the 19th August deadline was there to ensure that if the
> merge window opened while I was away, people wouldn't be complaining
> that stuff hadn't been merged.

In that case, could you pull this:

	git://git.marvell.com/orion for-rmk

It contains a single patch:

	[ARM] orion5x: Add LaCie NAS 2Big Network support

on top of what you already have.


Nicolas
