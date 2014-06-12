From: joe@perches.com (Joe Perches)
Date: Thu, 12 Jun 2014 09:05:59 -0700
Subject: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
In-Reply-To: <20140612153226.GE8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-9-git-send-email-r.sricharan@ti.com>
 <20140612131042.GU8664@titan.lakedaemon.net> <5399AC9C.4080602@ti.com>
 <1402582711.9947.17.camel@joe-AO725>
 <20140612153226.GE8664@titan.lakedaemon.net>
Message-ID: <1402589159.12385.4.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-12 at 11:32 -0400, Jason Cooper wrote:

Hi Jason.

> > But bugfix backports haven't been much of an issue in
> > other subsystems with fairly active whitespace/style
> > changes.
> 
> Most of the mvebu fixes we've had that failed to apply were generally
> due to a large whitespace change (dts node shuffling, admittedly not
> checkpatch-related).

So not due to this.

>   I've also frequently been stymied by code cleanups
> when using git blame to find the commit introducing a regression.

git blame -w can frequently help there.

> So, my general rule is: If you're submitting a patch to make checkpatch
> be quiet, re-assess the need.  If you're making changes and you can fix
> some checkpatch items while you're there, then do so.

Decent rule.

> There are certainly legitimate checkpatch-only patches, I just don't
> think this is one qualifies.

Of course it's the maintainer's choice (and last I saw,
that's you) to ignore whatever doesn't fit the appropriate
vision for the code.

$ ./scripts/get_maintainer.pl -f drivers/irqchip/irq-crossbar.c
Thomas Gleixner <tglx@linutronix.de> (maintainer:IRQCHIP DRIVERS)
Jason Cooper <jason@lakedaemon.net> (maintainer:IRQCHIP DRIVERS)
...

cheers, Joe
