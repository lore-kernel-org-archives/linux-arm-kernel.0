From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:31 +0800
Subject: [PATCH v4 03/11] ACPI: ARM64: IORT: add missing comment for
 iort_dev_find_its_id()
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-4-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

We are missing req_id's comment for iort_dev_find_its_id(),
add it back.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a52fc7e..c1405e5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
+ * @req_id: Device's Requster ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
-- 
1.7.12.4
