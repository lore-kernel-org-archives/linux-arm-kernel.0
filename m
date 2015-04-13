From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 13 Apr 2015 14:29:22 +0200
Subject: [RFC v6 07/16] VFIO: pci: initialize vfio_device_external_ops
In-Reply-To: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
References: <1428928171-18884-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1428928171-18884-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v6: creation
---
 drivers/vfio/pci/vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 2f865d07..755897f 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -855,6 +855,7 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.write		= vfio_pci_write,
 	.mmap		= vfio_pci_mmap,
 	.request	= vfio_pci_request,
+	.external_ops	= NULL,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
1.9.1
