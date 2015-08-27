From: agross@codeaurora.org (Andy Gross)
Date: Thu, 27 Aug 2015 16:29:01 -0500
Subject: [GIT PULL] qcom dt changes for 4.3-rc2
Message-ID: <1440710941-29302-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4040f37692ffbc602117d316c574a68a0fbfed93:

  Merge tag 'qcom-dt-for-4.3' into for-dt (2015-08-27 12:07:21 -0500)

are available in the git repository at:


  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-dt-for-4.3-rc2

for you to fetch changes up to cecd36b9c847b451e8ae297b53b094445b5352e4:

  ARM: dts: qcom: msm8974-sony-xperia-honami: Use stdout-path (2015-08-27 12:11:22 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.3-rc2

* Add labels for serial nodes to be used for aliasing and stdout-path
* Add stdout-path for APQ8064 Compulab QS600
* Add stdout-path for APQ8064 Inforce 6410
* Add stdout-path for APQ8074 Dragonboard
* Add stdout-path for APQ8084 Inforce 6540
* Add stdout-path for APQ8084 MTP
* Add stdout-path for IPQ8064 AP148
* Add stdout-path for MSM8660 Surf
* Add stdout-path for MSM8960 CDP
* Add stdout-path for MSM8974 Xperia Honami

----------------------------------------------------------------
Stephen Boyd (10):
      ARM: dts: qcom: Label serial nodes for aliasing and stdout-path
      ARM: dts: qcom: apq8064-cm-qs600: Use stdout-path
      ARM: dts: qcom: apq8064-ifc6410: Use stdout-path
      ARM: dts: qcom: apq8074-dragonboard: Use stdout-path
      ARM: dts: qcom: apq8084-ifc6540: Use stdout-path
      ARM: dts: qcom: apq8084-mtp: Use stdout-path
      ARM: dts: qcom: ipq8064-ap148: Use stdout-path
      ARM: dts: qcom: msm8660-surf: Use stdout-path
      ARM: dts: qcom: msm8960-cdp: Use stdout-path
      ARM: dts: qcom: msm8974-sony-xperia-honami: Use stdout-path

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |    8 ++++++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |    4 ++++
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |    8 ++++++++
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts         |    8 ++++++++
 arch/arm/boot/dts/qcom-apq8084-mtp.dts             |    8 ++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |    8 ++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts            |    8 ++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-msm8960-cdp.dts             |    8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi                |    2 +-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |    8 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |    2 +-
 14 files changed, 73 insertions(+), 5 deletions(-)
