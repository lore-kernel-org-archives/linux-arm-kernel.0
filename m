From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 20:41:12 +0000
Subject: [PATCH 0/9 v5] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <20120316202815.GI20243@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203162018.27957.arnd@arndb.de>
 <20120316202815.GI20243@titan.lakedaemon.net>
Message-ID: <201203162041.12831.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Jason Cooper wrote:
> I was going to give it a day or two more, and if no one brought up
> anything earth-shattering, I was going to submit the pull-request for
> this series on Sunday.  I can do it now if you think it's ok.

I've already pulled it now, and I'm not going to take any new patches
for v3.4 any more. I expect Linus to open up the merge window
any time now, and he does not like to see patches sent to him
that have not been in linux-next before the merge window opened.

So the deal is that anything that is in now stays in unless someone
reports a serious problem and in that case it gets removed.
Any simple bugs can be fixed by sending follow-up patches of
course.

> > I'm willing to take it and have put it into next/dt2 for now so it
> > makes it into linux-next. I'm not taking a newer version for v3.4 any
> > more, so if anyone has concerns over some of your patches in the
> > series, it all gets removed again and we will have to postpone them
> > until v3.5.
> 
> The problematic patch (sata_mv) has been removed.  So, there should be
> no issue.

Ok, thanks for the confirmation.

	Arnd
