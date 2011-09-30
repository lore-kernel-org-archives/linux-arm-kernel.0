From: khilman@ti.com (Kevin Hilman)
Date: Fri, 30 Sep 2011 15:29:07 -0700
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
In-Reply-To: <87aa9mm8ts.fsf@ti.com> (Kevin Hilman's message of "Fri, 30 Sep
	2011 06:57:35 -0700")
References: <87aa9mm8ts.fsf@ti.com>
Message-ID: <87k48pfyvg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Kevin Hilman <khilman@ti.com> writes:

> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
> in the irq/core branch of Thomas' tip tree[3].
>
> In the past, I noticed you merged external trees like this to solve
> dependencies.
>
> Could you pull the irq/core branch into your tree to meet this
> dependency?

On second thought, since Santosh's branch is the only one with this
dependency (and we also have a dependency on Russell's devel-stable)
I'll just build up a branch for Santosh's series that includes
rmk/devel-stable and tglx/irq-core.

You (or Tony) can then pull this one instead of manually managing the
dependencies.

Kevin
