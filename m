From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 4 Sep 2018 11:27:31 +0300
Subject: [RESEND PATCHv2 2/2] arm64: ti: add support for building Texas
 instruments overlays
In-Reply-To: <1536049651-10206-1-git-send-email-t-kristo@ti.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-1-git-send-email-t-kristo@ti.com>
Message-ID: <1536049651-10206-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the symbols to TI build DT files, for supporting overlays. Right now,
there are no overlay files introduced, those shall be added later on.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 63e619d..753de8c 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -6,4 +6,6 @@
 # Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
 #
 
+DTC_FLAGS += -@
+
 dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
