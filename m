From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Dec 2017 18:05:34 +0100
Subject: [PATCH v2 0/2]  cpufreq: Sort Kconfig and Makefile
Message-ID: <20171213170536.28238-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch of this series was originally part of the series "Add CPU
Frequency scaling support on Armada 37xx" [1].

As requested by Rafael J. Wysocki, these 2 patches are extracted in a
independent series, in the meantime, Viresh Kumar gave his acked-by
that I added to the patches.

In this second version only the 1st patch had been modified, see the
changelog for the details.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/546709.html

Changelog:
v1 -> v2:

 - Fixed tab vs space issue in KConfig, suggested by Randy Dunlap
 - Removed unneeded "default n" in KConfig, suggested by Randy Dunlap

Gregory CLEMENT (2):
  cpufreq: ARM: sort the Kconfig menu
  cpufreq: sort the drivers in ARM part

 drivers/cpufreq/Kconfig.arm | 81 ++++++++++++++++++++++-----------------------
 drivers/cpufreq/Makefile    |  8 ++---
 2 files changed, 44 insertions(+), 45 deletions(-)

-- 
2.15.1
