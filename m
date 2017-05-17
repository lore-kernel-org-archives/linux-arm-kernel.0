From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 17 May 2017 16:37:35 +0800
Subject: [PATCH 02/12] arm64: dts: hisilicon: update compatible string for
 hikey960
In-Reply-To: <20170517083745.24479-1-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
Message-ID: <20170517083745.24479-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update compatible string for hikey960. HiKey960 is a develpment board built
with SoC Hi3660.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 186251f..64875a5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "HiKey960";
-	compatible = "hisilicon,hi3660";
+	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
 		serial5 = &uart5;       /* console UART */
-- 
2.10.2
