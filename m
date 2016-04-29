From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Apr 2016 18:39:04 +0200
Subject: [GIT PULL] Allwinner fixes for 4.6
Message-ID: <20160429163904.GA6708@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the patch below for the next 4.6-rc*.

thanks!
Maxime

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.6

for you to fetch changes up to dcf5341f0150bc4c5bf37786e1198d2ff8fc2c38:

  ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw regulator (2016-03-27 16:13:51 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.6

A single regulator fix

----------------------------------------------------------------
Hans de Goede (1):
      ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw regulator

 arch/arm/boot/dts/sun8i-q8-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/3a5f1e93/attachment.sig>
