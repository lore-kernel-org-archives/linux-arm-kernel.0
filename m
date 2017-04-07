From: andy.gross@linaro.org (Andy Gross)
Date: Thu,  6 Apr 2017 21:48:50 -0500
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.12
Message-ID: <1491533330-13570-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.12

for you to fetch changes up to 21677ecca20151e61c3290ef37c5cd7afec60a5a:

  Revert "ARM: dts: qcom: msm8974: Add USB gadget nodes" (2017-04-06 18:48:53 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.12

* Add Coresight components for MSM8974
* Fixup MSM8974 ADSP XO clk and add RPMCC node
* Fix typo in APQ8060
* Add SDCs on MSM8660
* Revert MSM8974 USB gadget change due to issues

----------------------------------------------------------------
Andy Gross (1):
      Revert "ARM: dts: qcom: msm8974: Add USB gadget nodes"

Georgi Djakov (1):
      ARM: dts: qcom: msm8974: Add RPMCC DT node

Ivan T. Ivanov (1):
      ARM: dts: qcom: Add msm8974 CoreSight components

Jonathan Neusch?fer (1):
      ARM: dts: msm8974: Hook up adsp-pil's xo clock

Linus Walleij (2):
      ARM: dts: add SDC2 and SDC4 to the MSM8660 family
      ARM: dts: fix typo on APQ8060 Dragonboard

 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |   6 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  30 ++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   8 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 306 ++++++++++++++++++---
 4 files changed, 307 insertions(+), 43 deletions(-)
