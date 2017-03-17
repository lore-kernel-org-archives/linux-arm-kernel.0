From: andr2000@gmail.com (Oleksandr Andrushchenko)
Date: Fri, 17 Mar 2017 09:27:42 +0200
Subject: [PATCH v1] arm64: Add support for on-demand backtrace of other CPUs
Message-ID: <1489735663-2091-1-git-send-email-andr2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

Please ignore initial version of the patch in favor of this one:
this is the rebased and updated version of the [1] which unfortunately
haven't landed into the kernel and stuck at RFC stage.

Thank you,
Oleksandr Andrushchenko


[1] https://lkml.org/lkml/2016/8/19/591

Daniel Thompson (1):
  arm64: Add support for on-demand backtrace of other CPUs

 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/irq.h     |  6 ++++++
 arch/arm64/kernel/smp.c          | 30 +++++++++++++++++++++++++++++-
 lib/nmi_backtrace.c              |  8 ++++++--
 4 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.7.4
