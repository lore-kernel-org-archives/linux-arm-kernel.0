From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 21:50:07 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 arch timer frequency update
Message-ID: <20130709125007.4388.15701.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7790 arch timer frequency update

[PATCH 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
[PATCH 02/02] ARM: shmobile: Setup r8a7790 arch timer based on MD pins

Add code to setup r8a7790 arch timer frequency dynamically at boot time
based on the EXTAL frequency pointed out by the boot mode pins.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of renesas-next-20130704v2

 arch/arm/mach-shmobile/clock-r8a7790.c        |   11 ----
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   63 +++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 14 deletions(-)
