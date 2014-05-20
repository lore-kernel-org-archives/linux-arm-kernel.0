From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 10:11:20 +0900
Subject: [GIT PULL 3/5] Samsung driver update for 3.16
Message-ID: <014601cf73c8$68e56030$3ab02090$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-drivers

for you to fetch changes up to 93bfb769752babdc4d3665a1fb166bb4e3ff927b:

  clocksource: exynos_mct: register sched_clock callback (2014-05-02
22:27:01 +0900)

----------------------------------------------------------------
exynos_mct update for v3.16

- register sched_clock callback to use clocksource mct-frc

Note that got ack from Daniel

----------------------------------------------------------------
Vincent Guittot (1):
      clocksource: exynos_mct: register sched_clock callback

 drivers/clocksource/exynos_mct.c |    8 ++++++++
 1 file changed, 8 insertions(+)
