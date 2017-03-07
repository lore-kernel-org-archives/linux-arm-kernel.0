From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:39:57 +0800
Subject: [PATCH v9 02/15] ACPI/IORT: Add missing comment for
 iort_dev_find_its_id()
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1488890410-15503-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add missing req_id parameter to the iort_dev_find_its_id() function
kernel-doc comment.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2e368a6..abc5774 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -450,6 +450,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
+ * @req_id: Device's requester ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
-- 
1.7.12.4
