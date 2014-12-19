From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:40:57 +0530
Subject: [PATCH 0/2] Add pinctrl support for audio IPs on exynos7
Message-ID: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio interface IPs I2S, PCM and SPDIF on Exynos7 requires GPIOs
available on AUD and BUS0 pin controller blocks. So add support
for all. 

This patchset is dependent on BUS1 pin control support from Vivek
in the below link
https://patchwork.kernel.org/patch/5467321/

Padmavathi Venna (2):
  pinctrl: exynos: Add AUDIO pin controller for exynos7
  arm64: dts: Add pinctrl support for audio IPs on exynos7

 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |   56 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |    7 +++
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   10 ++++
 4 files changed, 74 insertions(+), 0 deletions(-)

-- 
1.7.4.4
