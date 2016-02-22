From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:51 +0530
Subject: [PATCH 02/61] gpio: Add resource management devm_gpio_chip_{add_data,
 remove}
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devm wrappers for the gpiochip_add_data() and gpiochip_remove().

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/driver-model/devres.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 831a536..8d8f944 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -252,6 +252,8 @@ GPIO
   devm_gpiod_get_index_optional()
   devm_gpiod_get_optional()
   devm_gpiod_put()
+  devm_gpiochip_add_data()
+  devm_gpiochip_remove()
 
 IIO
   devm_iio_device_alloc()
-- 
2.1.4
