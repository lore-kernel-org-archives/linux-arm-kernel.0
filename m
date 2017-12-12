From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Dec 2017 17:54:17 +0100
Subject: [PATCH 0/2] cpufreq: Sort Kconfig and Makefile
Message-ID: <20171212165419.752-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch of this series was originally part of the series "Add CPU
Frequency scaling support on Armada 37xx" [1].

As requested by Rafael J. Wysocki, these 2 patches are extracted in a
independent series, in the meantime, Viresh Kumar gave his acked-by
that I added to the patches.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/546709.html

Gregory CLEMENT (2):
  cpufreq: ARM: sort the Kconfig menu
  cpufreq: sort the drivers in ARM part

 drivers/cpufreq/Kconfig.arm | 82 ++++++++++++++++++++++-----------------------
 drivers/cpufreq/Makefile    |  8 ++---
 2 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.15.1
