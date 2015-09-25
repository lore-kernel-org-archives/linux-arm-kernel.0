From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 25 Sep 2015 20:35:06 +0300
Subject: [PATCH 0/5] ARM: dts: fix cpu compatible values
Message-ID: <1443202506-13732-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changeset corrects severeal cpu compatible properties
to defined ones in Documentation/devicetree/bindings/arm/cpus.txt

Vladimir Zapolskiy (5):
  ARM: dts: i.MX31: fix cpu compatible value
  ARM: dts: i.MX35: fix cpu compatible value
  ARM: dts: S3C2416: fix cpu compatible value
  ARM: dts: TI-Nspire: fix cpu compatible value
  ARM: dts: WM8750: fix cpu compatible value

 arch/arm/boot/dts/imx31.dtsi   | 2 +-
 arch/arm/boot/dts/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/nspire.dtsi  | 2 +-
 arch/arm/boot/dts/s3c2416.dtsi | 2 +-
 arch/arm/boot/dts/wm8750.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.1.4
