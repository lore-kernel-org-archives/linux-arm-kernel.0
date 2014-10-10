From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 10 Oct 2014 14:26:06 -0700
Subject: [PATCH v3 2/6] ARM: dts: rockchip: use the same pmu node name as
 before
In-Reply-To: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
References: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1412976370-14468-3-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use the "rockchip,rk3066-pmu" for rk3288 instead of creat
a new one.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- add this patch in version 3

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..06f39be 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -440,7 +440,7 @@
 	};
 
 	pmu: power-management at ff730000 {
-		compatible = "rockchip,rk3288-pmu", "syscon";
+		compatible = "rockchip,rk3066-pmu", "syscon";
 		reg = <0xff730000 0x100>;
 	};
 
-- 
1.9.1
