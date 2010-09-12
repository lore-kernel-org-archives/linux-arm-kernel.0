From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 12 Sep 2010 23:47:39 +0200
Subject: Regression on UP ARM from commit
	e18d65f0500b95d8724b17d8ea9f1116cf390bbe
Message-ID: <AANLkTimC5Vz7x9+MNJcewijoyw=Nyr6WWP=YR8cxqarH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

commit e18d65f0500b95d8724b17d8ea9f1116cf390bbe
"slub: Remove static kmem_cache_cpu array for boot"
made my ARM 926 UP system hang at boot, if I revert this (have
to back out a lot of SLUB patches for that) it comes back up. (Same if I
switch to SLAB.)

Any hints on how I can get patch around this in a nice way?

Yours,
Linus Walleij
