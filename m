From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 17 Mar 2017 11:32:44 +0800
Subject: [PATCH v2 3/3] arm64: dts: rockchip: disable mailbox of RK3368 SoCs
 defaultly
In-Reply-To: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
References: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1489721564-32203-4-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Default to disable mailbox in rk3368 core dts file.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v1:
- none

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 74fbcc2..eeb31f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -662,6 +662,7 @@
 		clocks = <&cru PCLK_MAILBOX>;
 		clock-names = "pclk_mailbox";
 		#mbox-cells = <1>;
+		status = "disabled";
 	};
 
 	pmugrf: syscon at ff738000 {
-- 
1.9.1
