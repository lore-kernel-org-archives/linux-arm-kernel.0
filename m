From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 25 May 2018 17:41:21 -0500
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.18 - Part 2
Message-ID: <1527288081-27486-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 90ce62659994b87723ec6ba26815f9634c18e449:

  ARM: dts: qcom-apq8064: use correct pci address for address translation (2018-05-14 15:22:28 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.18-2

for you to fetch changes up to 0e4c982096f873f893d0e7b59f5abb3ef234e667:

  ARM: dts: ipq8074: Enable few peripherals for hk01 board (2018-05-25 15:40:21 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.18 - Part 2

* Numerous updates for IPQ8074 and IPQ4019 based devices
* Add support for Sony Xperia Z1 Compact

----------------------------------------------------------------
Attila Sz?ll?si (1):
      ARM: dts: qcom: msm8974: Add Sony Xperia Z1 Compact

Sricharan R (12):
      ARM: dts: ipq4019: Add a default chosen node
      ARM: dts: ipq4019: Add a few peripheral nodes
      ARM: dts: ipq4019: Change the max opp frequency
      ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
      ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3 board file
      ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
      ARM: dts: ipq8074: Add peripheral nodes
      ARM: dts: ipq8074: Add pcie nodes
      ARM: dts: ipq8074: Enable few peripherals for hk01 board

 arch/arm/boot/dts/Makefile                         |   5 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      |  10 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |  19 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts    |   9 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      | 111 ++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts    |  64 +++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts    |  25 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |  75 ++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 162 +++++++-
 .../boot/dts/qcom-msm8974-sony-xperia-amami.dts    | 436 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  62 ++-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 313 ++++++++++++++-
 12 files changed, 1264 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
