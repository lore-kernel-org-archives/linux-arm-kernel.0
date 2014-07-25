From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Jul 2014 12:40:01 -0600
Subject: [PATCH 0/2] ARM: tegra: a couple of late DT patches
Message-ID: <1406313603-11893-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Here are a couple of fixe/cleanup patches to Tegra DT files that came in
late. They're based on top of Tegra's for-3.17/dt branch/pull-request.

Marcel Ziswiler (1):
  ARM: tegra: apalis t30: fix device tree compatible node

Thierry Reding (1):
  ARM: tegra: paz00: Fix some indentation inconsistencies

 arch/arm/boot/dts/tegra20-paz00.dts       | 6 +++---
 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
