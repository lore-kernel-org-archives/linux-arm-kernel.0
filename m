From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 17 Jul 2018 18:06:08 +0200
Subject: [PATCH 3/5] arm64: defconfig: Enable vctrl regulators for Gru/Kevin.
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com>
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Message-ID: <20180717160610.26501-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gru/Kevin uses vctrl regulators for dynamic CPU voltages, so enable in
the default defconfig in order to have support for cpufreq.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e530d6fc34b2..3fae8ada69e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -396,6 +396,7 @@ CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
+CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
 CONFIG_RC_DEVICES=y
-- 
2.18.0
