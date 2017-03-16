From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Mar 2017 16:16:28 +0100
Subject: [PATCH 2/2] arm64: defconfig: enable MVPP2
In-Reply-To: <1489677388-19320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1489677388-19320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1489677388-19320-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MVPP2 network driver is used for the ARM64 Marvell Armada 7K and 8K
platforms, so enable it in the arm64 defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028..fece4d3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -185,6 +185,7 @@ CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
+CONFIG_MVPP2=y
 CONFIG_SKY2=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
-- 
2.7.4
