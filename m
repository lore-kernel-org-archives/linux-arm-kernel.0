From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 18:51:24 +0100
Subject: [GIT PULL] Allwinner fixes for 4.10
Message-ID: <20170110175124.oqlucb6a2qut2ten@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for 4.10.

Thanks!
Maxime

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.10

for you to fetch changes up to 3116d37651d77125bf50f81f859b1278e02ccce6:

  ARM: dts: sunxi: Change node name for pwrseq pin on Olinuxino-lime2-emmc (2017-01-10 18:33:16 +0100)

----------------------------------------------------------------
Allwinner fixes for 4.10

A few fixes here and there to enable the build of some DT leftover, prevent
display issues or setup a proper muxing.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: dts: sun6i: Disable display pipeline by default
      ARM: dts: sun6i: hummingbird: Enable display engine again

Emmanuel Vadot (1):
      ARM: dts: sunxi: Change node name for pwrseq pin on Olinuxino-lime2-emmc

Milo Kim (1):
      ARM: dts: sun8i: Support DTB build for NanoPi M1

 arch/arm/boot/dts/Makefile                           | 1 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts          | 4 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi                     | 1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts | 2 +-
 4 files changed, 7 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/5ec32ec7/attachment.sig>
