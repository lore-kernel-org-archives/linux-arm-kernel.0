From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 14:22:41 -0700
Subject: [GIT PULL] Allwinner fixes for 4.0
Message-ID: <20150325212241.GA18315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are a few fixes to be merged in 4.0.

Thanks!
Maxime

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.0

for you to fetch changes up to 370a9b5fb04a0d5cc7b7699c788616d6976f4476:

  ARM: dts: sunxi: Remove overclocked/overvoltaged OPP (2015-03-24 14:50:38 -0700)

----------------------------------------------------------------
Allwinner fixes for 4.0

There's a few fixes to merge for 4.0, one to add a select in the machine
Kconfig option to fix a potential build failure, and two fixing cpufreq related
issues.

----------------------------------------------------------------
Chen-Yu Tsai (3):
      ARM: sunxi: Have ARCH_SUNXI select RESET_CONTROLLER for clock driver usage
      ARM: dts: sun4i: a10-lime: Override and remove 1008MHz OPP setting
      ARM: dts: sunxi: Remove overclocked/overvoltaged OPP

 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi               |  3 +--
 arch/arm/boot/dts/sun5i-a13.dtsi               |  3 +--
 arch/arm/boot/dts/sun7i-a20.dtsi               |  3 +--
 arch/arm/mach-sunxi/Kconfig                    |  8 ++------
 5 files changed, 21 insertions(+), 12 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/01e3e97b/attachment.sig>
