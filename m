From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 5 Mar 2015 07:13:31 -0600
Subject: [PATCH 4/4] ARM: dts: am437x-gp-evm: Enable RTC
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1425561211-31003-5-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

Enable RTC on am437x-gp-evm.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index f84d971..b2a16c2 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -651,3 +651,7 @@
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
2.3.0
