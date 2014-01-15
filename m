From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 21:25:39 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a7790 SYSC, SCU and CCI setup code
Message-ID: <20140115122539.9437.63968.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7790 SYSC, SCU and CCI setup code

[PATCH 01/04] ARM: shmobile: r8a7790 SYSC setup code
[PATCH 02/04] ARM: shmobile: r8a7790 CA7-SCU enablement
[PATCH 03/04] ARM: shmobile: r8a7790 CA15-SCU enablement
[PATCH 04/04] ARM: shmobile: r8a7790 CCI configuration

Add r8a7790 specific SYSC, SCU and CCI setup code.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc8-20140115,
 also requires "[PATCH] ARM: shmobile: Break out R-Car SYSC PM code"

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
 arch/arm/mach-shmobile/pm-r8a7790.c           |   45 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7790.c          |   32 +++++++++++++++++
 4 files changed, 79 insertions(+)
