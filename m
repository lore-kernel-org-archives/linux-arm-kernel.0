From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 24 Jul 2017 21:08:56 +0200
Subject: [GIT PULL 5/5] ARM: defconfig: Cleanups for v4.14
In-Reply-To: <20170724190856.19055-1-krzk@kernel.org>
References: <20170724190856.19055-1-krzk@kernel.org>
Message-ID: <20170724190856.19055-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Non-Samsung cleanups for defconfigs


Best regards,
Krzysztof


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-arm-cleanups-4.14

for you to fetch changes up to c1bdf1b9a11416e183484df42616c0bab125204a:

  ARM: qcom_defconfig: Cleanup from non-existing options (2017-07-18 17:51:33 +0200)

----------------------------------------------------------------
Bunch of ARM defconfig cleanups for v4.14

Cleanup ARMv7 defconfigs from options not existing anymore.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      ARM: multi_v7_defconfig: Cleanup from non-existing options
      ARM: ixp4xx_defconfig: Cleanup from non-existing options
      ARM: vexpress_defconfig: Cleanup from non-existing options
      ARM: ezx_defconfig: Cleanup from non-existing options
      ARM: qcom_defconfig: Cleanup from non-existing options

 arch/arm/configs/ezx_defconfig      | 1 -
 arch/arm/configs/ixp4xx_defconfig   | 4 ----
 arch/arm/configs/multi_v7_defconfig | 7 -------
 arch/arm/configs/qcom_defconfig     | 1 -
 arch/arm/configs/vexpress_defconfig | 1 -
 5 files changed, 14 deletions(-)
