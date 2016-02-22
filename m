From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:52 +0530
Subject: [PATCH 03/61] gpio: Add missing devm_gpio_ wrapper in devres.txt
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add following missing devm wrappers in file devrs.txt under
list of managed interfaces.
  devm_gpio_request()
  devm_gpio_request_one()
  devm_gpio_free()

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/driver-model/devres.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 8d8f944..73b98df 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -254,6 +254,9 @@ GPIO
   devm_gpiod_put()
   devm_gpiochip_add_data()
   devm_gpiochip_remove()
+  devm_gpio_request()
+  devm_gpio_request_one()
+  devm_gpio_free()
 
 IIO
   devm_iio_device_alloc()
-- 
2.1.4
