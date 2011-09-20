From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 20 Sep 2011 17:27:32 +0530
Subject: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4E787FAC.5070905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 September 2011 07:24 PM, Santosh Shilimkar wrote:
> This series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.
> 
Thanks all for your review's and testing of this series. Have addressed
all the concerns/comments as part of the next post which  I am holding
for couple of days more.

Reason is mainly to ensure that dependent patches(series) are merged or
on the way for 3.2, and the patches are re-based against the
right tree for the merge.

As documented earlier, there are 3 dependencies for this series.

1) Russell's L2 cache update to generic suspend which seems to be
be ready now since Lorenzo confirmed that pending issue is fixed.
http://www.spinics.net/lists/linux-omap/msg57625.html

2) CPU PM notifier series for which I have pull request ready
to be send.
https://lkml.org/lkml/2011/9/3/49

3) IRQ subystem patch which is already in Thomas's irq/core for 3.2
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg55483.html

Regards
Santosh
