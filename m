From: khilman@ti.com (Kevin Hilman)
Date: Fri, 30 Sep 2011 06:57:35 -0700
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
Message-ID: <87aa9mm8ts.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

The upcoming OMAP4 PM series from Santosh[1] that we're planning to
queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
in the irq/core branch of Thomas' tip tree[3].

In the past, I noticed you merged external trees like this to solve
dependencies.

Could you pull the irq/core branch into your tree to meet this
dependency?

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=131684489920440&w=2
[2] http://marc.info/?l=linux-omap&m=131581416908252&w=2
[3] currently here: git://tesla.tglx.de/git/linux-2.6-tip
