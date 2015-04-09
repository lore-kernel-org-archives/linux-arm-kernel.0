From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  9 Apr 2015 09:21:14 +0100
Subject: [PATCH 00/10] ARM: dts: apq8064 dt patches.
Message-ID: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar, 

Now that the rpm redesign dependency is resolved, If its not too late could you
queue these dt patches for v4.1 or v4.1-rc1.

I tested these patches on APQ8064 based IFC6410 board with SATA/USB/HDMI.

I also rebased these patche on top of your qcom/dt branch.


Thanks,
srini

Nicolas Dechesne (2):
  ARM: dts: apq8064: Add usb host support to CM QS-600
  ARM: dts: apq8064: Add USB OTG support for CM QS-600

Pramod Gurav (1):
  ARM: dts: qcom: Add DT alias for serial port

Rob Clark (1):
  ARM: dts: apq8064: Add MDP support

Srinivas Kandagatla (6):
  ARM: dts: apq8064: add RPM regulators support
  ARM: dts: apq8064: Add usb host support.
  ARM: dts: apq8064: Add USB OTG support
  ARM: dts: apq8064: Add SATA controller support.
  ARM: dts: Move i2c1 pinctrl to apq8064.dtsi
  ARM: dts: apq8064 add i2c3 node for panel.

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts |  30 ++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  |  69 +++-
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 528 +++++++++++++++++++++++++++-
 3 files changed, 618 insertions(+), 9 deletions(-)

-- 
1.9.1
