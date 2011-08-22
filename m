From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 22 Aug 2011 14:09:36 +0100
Subject: [PATCH 0/3 v3] ARM Realview PCIX preparation
Message-ID: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of some patches that were posted before.

The following series implements the preparatory work for adding PCI
support to the ARM Realview family of boards.

---

Colin Tuckley (3):
      RM Realview PCIX board file changes
      ARM Realview PCIX IRQ include file changes
      ARM Realview PCIX map include file changes


 arch/arm/mach-realview/include/mach/board-pb11mp.h |   11 ----
 arch/arm/mach-realview/include/mach/board-pba8.h   |   11 ----
 arch/arm/mach-realview/include/mach/board-pbx.h    |   11 ----
 arch/arm/mach-realview/include/mach/hardware.h     |   53 ++++++++++++++++++++
 arch/arm/mach-realview/include/mach/io.h           |   18 ++++++-
 arch/arm/mach-realview/include/mach/irqs-pb11mp.h  |   11 ++++
 arch/arm/mach-realview/include/mach/irqs-pba8.h    |    7 ++-
 arch/arm/mach-realview/include/mach/irqs-pbx.h     |    7 ++-
 arch/arm/mach-realview/include/mach/platform.h     |   15 +-----
 arch/arm/mach-realview/realview_pb11mp.c           |   18 +++++++
 arch/arm/mach-realview/realview_pba8.c             |   18 +++++--
 arch/arm/mach-realview/realview_pbx.c              |   16 +++++-
 12 files changed, 140 insertions(+), 56 deletions(-)

-- 

Colin
