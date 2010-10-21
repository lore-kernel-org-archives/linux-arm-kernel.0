From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 15:44:40 +0900
Subject: [PATCH V3 0/3] ARM: S5PV310: Move and Update L2 cache init code
Message-ID: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves L2X0 cache init code from each machine to ARCH_S5PV310's cpu.c
for common usage and updates its feature such as L2X0 Prefetch and Power control
configuration.

Changes since v1 and v2:
- updated L2 cache init function's features.

[PATCH V3 1/3] ARM: Add L2X0 PREFETCH and POWER control register
[PATCH V3 2/3] ARM: S5PV310: Remove L2 cache init in machine
[PATCH V3 3/3] ARM: S5PV310: Add L2 cache init function in cpu.c
