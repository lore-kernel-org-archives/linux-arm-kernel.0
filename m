From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 09:11:56 +0100
Subject: [PATCH v2 0/3] DT: APQ8064 remove mmc fixed regulators.
Message-ID: <1438071116-30065-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

This patchset removes the fixed regulators with real regulators
on IFC6410 and QS600 board.

This patchset is based on qcom/dt branch.

Thanks,
srini

Srinivas Kandagatla (3):
  ARM: dts: apq8064: remove temporary fixed regulator for mmc
  ARM: dts: ifc6410: add real regulators for sdcc nodes.
  ARM: dts: qs600: Add real regulators to sdcc

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 12 ------------
 3 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.9.1
