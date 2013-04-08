From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Apr 2013 10:23:18 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 Lager arch timer fixes
Message-ID: <20130408012318.13555.58237.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7790 Lager arch timer fixes

[PATCH 01/02] ARM: shmobile: force enable of r8a7790 arch timer 
[PATCH 02/02] ARM: shmobile: use r8a7790 timer setup code on Lager

This mini-series contains fixes to start the arch timer on
r8a7790 and the Lager board regardless of boot loader setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-next-20130405v2 in renesas.git
 
 arch/arm/mach-shmobile/board-lager.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   14 +++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)
