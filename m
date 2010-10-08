From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Oct 2010 00:04:51 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
Message-ID: <20101008230451.GB10975@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 10:37:10PM +0300, Felipe Contreras wrote:
> People have been discussing them, but you can't expect a perfect
> solution to pop up within one release cycle, specially when people
> have real issues to deal with.

Two release cycles.  It was queued for the previous release, was posted
to the mailing list, was de-queued, and then re-added for the last merge
window.

That's not no warning - that's almost six months.

http://lists.arm.linux.org.uk/lurker/message/20100408.094818.d6854bd5.en.html

So what you're telling me is that in six months, not one driver has been
touched to address this issue?  So, if no one in that time has done any
work on this, then what use is it going to be making the kernel issue
a warning instead?

So, since this has been known about for six months to the day, I completely
fail to see how making this a warning instead will create the necessary
motivation for the issue to be addressed.
