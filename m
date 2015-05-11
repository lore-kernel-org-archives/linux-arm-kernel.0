From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 May 2015 21:35:27 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
Message-ID: <20150511193527.GA29690@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the first batch of drivers changes for the 4.2 merge window.

Thanks!
Maxime

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.2

for you to fetch changes up to 44bb362ff9f2e6f9ab285e66ce92f55aee71808a:

  drivers: soc: sunxi: Introduce SoC driver to map SRAMs (2015-05-05 20:47:08 +0200)

----------------------------------------------------------------
Allwinner drivers patches for 4.2

This pull request contain a single driver to handle the SRAM mapping
between the CPU and devices.

----------------------------------------------------------------
Maxime Ripard (1):
      drivers: soc: sunxi: Introduce SoC driver to map SRAMs

 .../devicetree/bindings/soc/sunxi/sram.txt         |  64 ++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/sunxi/Kconfig                          |  10 +
 drivers/soc/sunxi/Makefile                         |   1 +
 drivers/soc/sunxi/sunxi_sram.c                     | 236 +++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_sram.h               |  24 +++
 7 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/b3a3607a/attachment.sig>
