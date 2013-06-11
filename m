From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 11 Jun 2013 13:11:17 +0300
Subject: [PATCH 0/2 v2] Bugfixes for Tegra memory controllers.
Message-ID: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's two simple bugfixes for the Tegra memory controllers.

v2: Fix a dumb bug in the bit masking.

Tuomas Tynkkynen (2):
  memory: tegra20-mc: Fix hang in IRQ handler.
  memory: tegra30-mc: Fix IRQ handler.

 drivers/memory/tegra20-mc.c | 5 ++++-
 drivers/memory/tegra30-mc.c | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.8.1.5
