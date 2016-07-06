From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:27 +0100
Subject: [PATCH v6 09/18] ARM: multi_v7_defconfig: Enable STi and simple-card
 drivers.
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the STi ALSA drivers found on STi platforms
as well as the simple-card driver which is a dependency to have
working sound.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: arnaud.pouliquen at st.com
Cc: broonie at kernel.org
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 541c914..9cf9141 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -608,6 +608,9 @@ CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_SGTL5000=m
 CONFIG_SND_SOC_SPDIF=m
 CONFIG_SND_SOC_WM8978=m
+CONFIG_SND_SOC_STI=m
+CONFIG_SND_SOC_STI_SAS=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
-- 
1.9.1
