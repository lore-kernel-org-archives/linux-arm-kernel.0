From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  2 Jul 2015 15:17:14 +0200
Subject: [RFC 04/17] VFIO: pci: initialize vfio_device_external_ops
In-Reply-To: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1435843047-6327-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v6: creation
---
 drivers/vfio/pci/vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 964ad57..1e48125 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -929,6 +929,7 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.write		= vfio_pci_write,
 	.mmap		= vfio_pci_mmap,
 	.request	= vfio_pci_request,
+	.external_ops	= NULL,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
1.9.1
