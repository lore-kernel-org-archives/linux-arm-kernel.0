From: wni@nvidia.com (Wei Ni)
Date: Fri, 21 Sep 2012 16:55:00 +0800
Subject: [PATCH v2 5/5] ARM: tegra: enable brcmfmac in defconfig
In-Reply-To: <1348217700-12309-1-git-send-email-wni@nvidia.com>
References: <1348217700-12309-1-git-send-email-wni@nvidia.com>
Message-ID: <1348217700-12309-6-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New options enabled:
* CFG80211_WEXT: (dependency)
* BRCMFMAC: wlan driver, enable as module.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index adcf3c2..04b18ea 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -73,6 +73,7 @@ CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
 CONFIG_BT_HCIBTUSB=m
 CONFIG_CFG80211=y
+CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
 CONFIG_RFKILL=y
 CONFIG_RFKILL_INPUT=y
@@ -98,6 +99,7 @@ CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
+CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_EVDEV=y
-- 
1.7.1
