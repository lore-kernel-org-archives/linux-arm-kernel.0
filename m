From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 18 Aug 2015 14:04:29 +0100
Subject: [PATCH v2 0/6] DT: APQ8064 for qcom-dt-next
Message-ID: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Apologies for the long delay in sending new version of the patches.
Here are the new patches with fixes and dropping the MDP and panel
related changes.

Some dt patches which depend on pmic header
 "dt-bindings/pinctrl/qcom,pmic-gpio.h" which is availble in linux-next.


Changes since v1(https://lkml.org/lkml/2015/7/28/489)
 - Fixed style related errors spotted by Stephen and Bjorn
 - dropped mdp and Panel related DT, as it seems to go no where
  w.r.t cleaning up the driver.
 - Added few more patches for qs600 which are very trival.

 thanks,
 srini

Srinivas Kandagatla (6):
  ARM: dts: ifc6410: Add pwrseq support for WLAN
  ARM: dts: qs600: add pwrseq support to WLAN
  ARM: dts: apq8064-ifc6410: add notify led support.
  ARM: dts: qs600: remove unnecessary i2c pinctrl nodes in board file.
  ARM: dts: qs600: add alias to serial0
  ARM: dts: qs600: Add SD card detect support.

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 46 +++++++++++++++++++++++--
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 52 +++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 3 deletions(-)

-- 
1.9.1
