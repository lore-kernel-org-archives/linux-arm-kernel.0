From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 19 Mar 2018 21:28:01 -0500
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.17
In-Reply-To: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
References: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1521512881-1854-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.17

for you to fetch changes up to 84d9bba0762e0a8e5dc66d25826a306e26177e6f:

  ARM: dts: msm8974: castor: Fix typo and add startup delay in touchscreen node (2018-03-15 00:23:41 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.17

* Add initial DTS file for Samsung Galaxy S5
* Fixups for castor touchscreen node
* Fixup QS600 at23 manufacturer
* Add XOADC and IIO to APQ8064

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: dts: use 'atmel' as at24 manufacturer for qcom-apq8064-cm-qs600

Craig Tatlor (1):
      ARM: dts: msm8974: castor: Fix typo and add startup delay in touchscreen node

Daniele Debernardi (1):
      ARM: dts: qcom: Add initial DTS file for Samsung Galaxy S5 phone

Linus Walleij (1):
      ARM: dts: add XOADC and IIO HWMON to APQ8064

 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 63 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts    | 24 +++++++++
 .../boot/dts/qcom-msm8974-sony-xperia-castor.dts   |  4 +-
 5 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
