From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Sep 2012 11:02:54 -0600
Subject: [PATCH] irqchip: fill in empty Kconfig
Message-ID: <1348506174-28641-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 89214f0 "ARM: bcm2835: add interrupt controller driver" added an
empty drivers/irqchip/Kconfig. Empty files apparently don't work well
with git (sometimes, with some versions?) so add some dummy content to
resolve this issue.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/irqchip/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e69de29..1bb8bf6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -0,0 +1 @@
+# empty
-- 
1.7.0.4
