From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 18 Jan 2017 20:54:52 +0800
Subject: [PATCH v8 02/15] ACPI: IORT: add missing comment for
 iort_dev_find_its_id()
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1484744105-53140-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add missing req_id parameter to the iort_dev_find_its_id() function
kernel-doc comment.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ce3084b..15f32bf 100644
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
