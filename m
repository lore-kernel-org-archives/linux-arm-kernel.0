From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 23:28:26 +0100
Subject: [GIT PULL] Allwinner DT changes for 3.14
Message-ID: <20131220222826.GA23980@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.14

for you to fetch changes up to 81ee429ffdd021626bf191bb8a3ae886dd94adcc:

  ARM: sun6i: dt: Add IP needed to bring up the additional cores (2013-12-16 21:15:12 +0100)

----------------------------------------------------------------
Allwinner sunXi DT Additions for 3.14

Various DT related patches, but mostly:
  - Support for the Olimex A13-olinuxino-micro
  - Added the needed IP in the A31 for the HS timer support and SMP bringup
  - A10 and A20 RTC

----------------------------------------------------------------
Carlo Caione (1):
      ARM: dts: sun4i/sun7i: add RTC node

Emilio L?pez (1):
      ARM: sunxi: dt: add EMAC aliases

Hans de Goede (1):
      ARM: dts: sun5i: Add new sun5i-a13-olinuxino-micro board

Maxime Ripard (2):
      ARM: sun6i: Add the reset controller to the DTSI
      ARM: sun6i: dt: Add IP needed to bring up the additional cores

 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/sun4i-a10.dtsi                | 10 ++++
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  4 ++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts | 68 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                | 34 +++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 10 ++++
 6 files changed, 127 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/c438942a/attachment.sig>
