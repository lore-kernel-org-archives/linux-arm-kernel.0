From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 27 Aug 2018 22:14:43 -0700
Subject: [PATCH] arm64: defconfig: Enable Qualcomm QRTR
Message-ID: <20180828051443.22777-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QRTR packet family is used for a wide range of communication between
services in Qualcomm platforms. Examples of services using this
transport for communication are remoteproc management, modem control,
positioning, power management and WiFi.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..c508462d4c49 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -149,6 +149,9 @@ CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
+CONFIG_QRTR=m
+CONFIG_QRTR_SMD=m
+CONFIG_QRTR_TUN=m
 CONFIG_BPF_JIT=y
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
-- 
2.18.0
