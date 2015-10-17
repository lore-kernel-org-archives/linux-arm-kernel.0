From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Oct 2015 18:51:14 +0200
Subject: [GIT PULL] Allwinner core changes for 4.4
Message-ID: <20151017165114.GA15258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag that adds the needed code to support the
R8 properly.

Thanks!
Maxime

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.4

for you to fetch changes up to bef6229f36c1c2ddae186f4e328c2359c1dad18d:

  ARM: sunxi: Add R8 support (2015-10-17 18:47:28 +0200)

----------------------------------------------------------------
Allwinner core changes for 4.4

Add support for the Allwinner R8 SoC used in the CHIP.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Add R8 support

 Documentation/arm/sunxi/README                  | 2 +-
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 3 ++-
 drivers/clk/sunxi/clk-sunxi.c                   | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/7a7200c9/attachment.sig>
