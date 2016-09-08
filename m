From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 15:34:42 +0200
Subject: [GIT PULL] Qualcomm EBI2 bindings and bus driver
Message-ID: <CACRpkdYvowN2htUuN46JNVdfaKNw3AEbBfzAeScHQcLU5o3ZUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull this new EBI2 bus driver and its bindings into an
apropriate branch in the ARM SoC tree. The binding now has
Rob Herrings ACK and we have hopefully finally figured out how
this should be done.

Yours,
Linus Walleij

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/qcom-ebi2-arm-soc

for you to fetch changes up to 335a127548081322bd2b294d715418648912f20c:

  bus: qcom: add EBI2 driver (2016-09-08 15:27:05 +0200)

----------------------------------------------------------------
Qualcomm EBI2 bindings and bus driver.

----------------------------------------------------------------
Linus Walleij (2):
      bus: qcom: add EBI2 device tree bindings
      bus: qcom: add EBI2 driver

 .../devicetree/bindings/bus/qcom,ebi2.txt          | 138 +++++++
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/qcom-ebi2.c                            | 408 +++++++++++++++++++++
 4 files changed, 554 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.txt
 create mode 100644 drivers/bus/qcom-ebi2.c
