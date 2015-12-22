From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Dec 2015 21:54:46 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.5, round 2
Message-ID: <20151222205446.GA20757@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following late changes for the Allwinner SoCs.

I expect it to be the last pull request for the 4.5 merge window on
our side.

Thanks!
Maxime

The following changes since commit 2367cee5fda1e9ebc605b13175492b31030acd9d:

  ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3 (baseboard SD socket) (2015-12-11 09:21:29 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-dt-for-4.5-2

for you to fetch changes up to 12ec9384036304e64904afdc6234b842fe54f411:

  ARM: dts: sun5i: Add dts file for the Empire Electronix D709 tablet (2015-12-21 17:10:18 +0100)

----------------------------------------------------------------
Allwinner DT patches, round 2

Mostly some audio codec patches to enable it on more boards, and a bunch
devices activation (Ethernet, touchscreen, backlights). One more board has
been added too.

----------------------------------------------------------------
Aleksei Mamlin (4):
      ARM: dts: sun7i: Enable PWM controller on Wexler TAB7200 tablet
      ARM: dts: sun7i: Enable touchscreen on Wexler TAB7200 tablet
      ARM: dts: sun7i: Add backlight node to Wexler TAB7200 tablet
      ARM: dts: sun7i: Add PA gpio pin to Wexler TAB7200 tablet

Hans de Goede (4):
      ARM: dts: sun5i: Enable onboard codec used on the UTOO P66 tablet
      ARM: dts: sun4i: Enable onboard codec used on the pov protab2-ips9 tablet
      ARM: dts: sun7i: Enable gmac on Wits Pro A20 DKT
      ARM: dts: sun5i: Add dts file for the Empire Electronix D709 tablet

Marcus Cooper (2):
      ARM: sunxi: dt: enable audio codec on mk802
      ARM: dt: sun7i: Enable audio codec on MK808C

Priit Laes (1):
      ARM: dts: sun4i: gemei-g9: Enable PA GPIO pin configuration

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  14 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   4 +
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |  14 ++
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  | 241 +++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  14 ++
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   4 +
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  53 +++++
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |  12 +
 9 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/735f46aa/attachment-0001.sig>
