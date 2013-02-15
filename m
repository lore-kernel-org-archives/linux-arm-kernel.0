From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:55 +0000
Subject: [PATCH 24/35] mfd: ab8500: Remove unnecessary 'struct device'
 declaration
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch saw the device.h include being removed from some other
include files and replaced with a 'struct device' declaration instead.
However, neither the include nor the declaration is actually required.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/abx500.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index bd480b2..cb3288b 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -13,8 +13,6 @@
 
 #include <linux/regulator/machine.h>
 
-struct device;
-
 #ifndef MFD_ABX500_H
 #define MFD_ABX500_H
 
-- 
1.7.10.4
