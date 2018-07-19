From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jul 2018 00:37:32 -0700
Subject: [GIT PULL] one omap fix for v4.18-rc cycle
Message-ID: <pull-1531985748-704286@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 923847413f7316b5ced3491769b3fefa6c56a79a:

  ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller (2018-07-12 06:57:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/fixes-rc5-signed

for you to fetch changes up to d3f6daede246038cf2ea38b78d732f9dd8feb1d6:

  ARM: dts: omap4-droid4: fix dts w.r.t. pwm (2018-07-16 23:38:52 -0700)

----------------------------------------------------------------
One omap dts mismerge fix

The dts patch for droid4 PWM vibrator has added gpio6 entries to the wrong
node. Let's fix it with a note that there seems to be also other GPIO PWM
issues to fix still to get the PWM vibrator working. So this can wait for
v4.19 merge cycle if necessary.

----------------------------------------------------------------
Pavel Machek (1):
      ARM: dts: omap4-droid4: fix dts w.r.t. pwm

 arch/arm/boot/dts/omap4-droid4-xt894.dts | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
