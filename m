From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 22 Oct 2018 11:27:22 +0200
Subject: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless
 SOM variant
Message-ID: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
QCA6564 wireless chip with dual WiFi and Bluetooth.

The QCA6564 uses the out-of-tree driver at:
https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-2.0/

Blueooth uses the HCI H4 UART driver.

Changes since [1]:
* Removed extra new line

[1] https://lore.kernel.org/lkml/1539962141-32418-2-git-send-email-alex.gonzalez at digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant

 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
