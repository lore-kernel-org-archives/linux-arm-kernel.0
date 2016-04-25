From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 25 Apr 2016 10:47:55 +0100
Subject: [PATCH 2/4] drivers: firmware: psci: remove duplicate const qualifier
In-Reply-To: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
Message-ID: <1461577678-29517-2-git-send-email-eric.engestrom@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8..0ab477ba 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -563,7 +563,7 @@ static int __init psci_0_1_init(struct device_node *np)
 	return err;
 }
 
-static const struct of_device_id const psci_of_match[] __initconst = {
+static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
 	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
-- 
2.7.4
