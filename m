From: xobs@kosagi.com (Sean Cross)
Date: Thu,  7 Mar 2013 06:00:07 +0000
Subject: [PATCH v2 0/3] ARM: dts: imx6q: Add additional pinctrl entries
Message-ID: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
	- Pull from shawnguo's imx/dt branch
	- Use macro names rather than hardcoded vlaues

This series adds imx6q dts pinctrl entries for ecspi3, i2c2, i2c3, and aud3.

Sean Cross (3):
  ARM: dts: imx6q: Add pinctrl for ecspi3
  ARM: dts: imx6q: Add pinctrl for i2c2 and i2c3
  ARM: dts: imx6q: Add pinctrl for audmix on AUD3

 arch/arm/boot/dts/imx6q.dtsip |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

-- 
1.7.9.5
