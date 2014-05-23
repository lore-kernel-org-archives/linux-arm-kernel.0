From: mporter@linaro.org (Matt Porter)
Date: Fri, 23 May 2014 09:11:43 -0400
Subject: [GIT PULL] ARM: mach-bcm: soc updates for 3.16
Message-ID: <20140523131143.GA24064@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following mach-bcm soc updates for 3.16.

-Matt

The following changes since commit eeda4cb92ee0fb63a5917738e107b0bc8168079e:

  ARM: bcm: rename "kona.h" and "kona.c" (2014-04-25 08:51:38 -0400)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/for-3.16/bcm-soc

for you to fetch changes up to 387468d190f0ba72e239c11e9663cfeaeaf9ae2d:

  ARM: bcm_defconfig: Enable PWM and Backlight (2014-04-28 11:10:29 -0400)

----------------------------------------------------------------
mach-bcm 3.16 soc updates:

* only show ARCH_BCM in multi v6/v7 configs
* enable ARM erratum 775420
* bcm_defconfig updates for pwm

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: bcm: Restrict ARCH_BCM selection to ARCH_MULTI_V6_V7

Scott Branden (1):
      ARM: mach-bcm: add ARM_ERRATA_775420

Tim Kryger (1):
      ARM: bcm_defconfig: Enable PWM and Backlight

 arch/arm/configs/bcm_defconfig |  3 +++
 arch/arm/mach-bcm/Kconfig      | 12 ++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)
