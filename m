From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 Aug 2012 22:41:00 +0800
Subject: [GIT PULL] mxs fixes for 3.6
Message-ID: <20120804144058.GB3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs fixes for 3.6.

Regards,
Shawn

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes-for-3.6

Fabio Estevam (2):
      ARM: mx23: Fix registers range
      ARM: mx28: Fix registers range

Marek Vasut (1):
      ARM: mxs: Remove MMAP_MIN_ADDR setting from mxs_defconfig

 arch/arm/boot/dts/imx23.dtsi   |   52 ++++++++++++++--------------
 arch/arm/boot/dts/imx28.dtsi   |   74 ++++++++++++++++++++--------------------
 arch/arm/configs/mxs_defconfig |    1 -
 3 files changed, 63 insertions(+), 64 deletions(-)
