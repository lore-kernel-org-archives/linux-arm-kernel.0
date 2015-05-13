From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 May 2015 16:41:25 +0100
Subject: [PATCH RESEND v6 0/6] mfd: axp20x: add AXP221 PMIC support
In-Reply-To: <1428638946-24890-1-git-send-email-wens@csie.org>
References: <1428638946-24890-1-git-send-email-wens@csie.org>
Message-ID: <20150513154125.GA19543@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Enjoy!

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-regulator-v4.2

for you to fetch changes up to 6d4fa89dcd85e2427da83319ce75e5df5febcc96:

  mfd: axp20x: Enable AXP22X regulators (2015-05-13 16:26:34 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator, due for v4.2

----------------------------------------------------------------
Boris BREZILLON (3):
      mfd: axp20x: Add AXP22x PMIC support
      regulator: axp20x: Prepare support for multiple AXP chip families
      regulator: axp20x: Add support for AXP22X regulators

Chen-Yu Tsai (3):
      mfd: axp20x: Update DT bindings with AXP22x compatibles
      mfd: axp20x: Add AXP22x regulator information to DT bindings
      mfd: axp20x: Enable AXP22X regulators

 Documentation/devicetree/bindings/mfd/axp20x.txt |  32 ++-
 drivers/mfd/axp20x.c                             | 100 ++++++++++
 drivers/regulator/axp20x-regulator.c             | 239 ++++++++++++++++++-----
 include/linux/mfd/axp20x.h                       |  86 ++++++++
 4 files changed, 405 insertions(+), 52 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
