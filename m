From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:27 +0530
Subject: [PATCH 02/50] pinctrl: Add resource management devm_pinctrl_{register,
 unregister}
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new member of devm wrappers for the pinctrl_register and
pinctrl_unregister in list of managed interfaces.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/driver-model/devres.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 831a536..eed5e56 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -323,6 +323,8 @@ PHY
 PINCTRL
   devm_pinctrl_get()
   devm_pinctrl_put()
+  devm_pinctrl_register()
+  devm_pinctrl_unregister()
 
 PWM
   devm_pwm_get()
-- 
2.1.4
