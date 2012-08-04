From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 Aug 2012 22:54:47 +0800
Subject: [GIT PULL] mxs fixes for 3.6
In-Reply-To: <20120804144058.GB3405@S2101-09.ap.freescale.net>
References: <20120804144058.GB3405@S2101-09.ap.freescale.net>
Message-ID: <20120804145445.GD3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2012 at 10:41:00PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> Please pull the following mxs fixes for 3.6.
> 
One fix was missed there.  Updated request is below.

Regards,
Shawn

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes-for-3.6

Fabio Estevam (2):
      ARM: mx23: Fix registers range
      ARM: mx28: Fix registers range

Marc Kleine-Budde (1):
      ARM: mxs: always build ocotp

Marek Vasut (1):
      ARM: mxs: Remove MMAP_MIN_ADDR setting from mxs_defconfig

 arch/arm/boot/dts/imx23.dtsi   |   52 ++++++++++++++--------------
 arch/arm/boot/dts/imx28.dtsi   |   74 ++++++++++++++++++++--------------------
 arch/arm/configs/mxs_defconfig |    1 -
 arch/arm/mach-mxs/Kconfig      |    6 ---
 arch/arm/mach-mxs/Makefile     |    3 +-
 5 files changed, 64 insertions(+), 72 deletions(-)
