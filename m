From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 13:00:00 -0700
Subject: [PATCH 0/3] Few omap2plus_defconfig updates
Message-ID: <1426536003-7077-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few minor updates to add support for things as loadable
modules to omap2plus_defconfig for a few devices I noticed we
are not enabling by default.

Regards,

Tony


Tony Lindgren (3):
  ARM: omap2plus_defconfig: Enable leds-pwm
  ARM: omap2plus_defconfig: Update bluetooth options
  ARM: omap2plus_defconfig: Enable n900 modem as loadable modules

 arch/arm/configs/omap2plus_defconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.1.4
