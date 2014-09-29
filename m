From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 29 Sep 2014 10:14:04 +0100
Subject: [PATCH 0/4] ARM: DT: apq8064 DT patches.
Message-ID: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches adds dt nodes for RPM, USB and SATA IPs found in APQ8064.
All the driver support for these IPs are already available in v3.17, except
the RPM driver which is now accepted by Lee and Mark.

These patches depend on the header file from 
http://www.spinics.net/lists/arm-kernel/msg364310.html
for regulators.

Now that the RPM patch is accepted, should RPM patch go via arm-soc tree?
so that we can get more functionality on IFC6410 board in v3.18 mainline.

All these patches are tested on IFC6410 board.
Am hoping to get these patches for v3.18, as these patches were sitting in
my dev tree since last 3 merge windows.

Thanks,
srini

Srinivas Kandagatla (4):
  ARM: DT: apq8064: add rpm support
  ARM: DT: apq8064: Add usb host support.
  ARM: DT: apq8064: Add USB OTG support
  ARM: DT: apq8064: Add SATA controller support.

 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  30 +++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 190 +++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+)

-- 
1.9.1
