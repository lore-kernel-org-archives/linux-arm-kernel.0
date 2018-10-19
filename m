From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Fri, 19 Oct 2018 17:15:40 +0200
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM
 variant
Message-ID: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
QCA6564 wireless chip with dual WiFi and Bluetooth.

The QCA6564 uses the out-of-tree driver at:
https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-2.0/

Blueooth uses the HCI H4 UART driver.

Alex Gonzalez (1):
  ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant

 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
