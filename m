From: john@johnandjuliet.com (john at johnandjuliet.com)
Date: Mon, 04 Apr 2011 08:41:08 -0700
Subject: [TuxOnIce-devel] [RFC PATCH] Current status,
	suspend-to-disk support on ARM
Message-ID: <20110404084108.98fd97237cc930a62b888eb89e535f85.03cdcb032e.wbe@email12.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wow.. More stuff to look at.

My status with the past patch is this:

1) I can suspend (swsusp) or at least it is pretending to

2) Cannot resume... Using resume=/dev/block/mmcblk1p2 or
CONFIG_PM_STD_PARTITION="/dev/block/mmcblk1p2"
does nothing.. the system just boots normally.

Going through the previous patches and found a few discrepencies that I
am looking closer at and will comment on soon.

Meanwhile doing a side build anyway to start to look at the TOI patches
into this (OMAP4 Android) kernel.


Ive got a small group here now interested to make this work so we may be
able to get more progress.  Not all are kernel experts but they are
fairly sharp guys with low-level experience...



> Hi,
> 
> some status on making hibernation (suspend-to-disk) work on ARM.
> 
> I've simplified an updated patch set again, to make the pieces obvious. 
> The attached patch set also cleanly compiles when adding TuxOnIce to it.
> 
