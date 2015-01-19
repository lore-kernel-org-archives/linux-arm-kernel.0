From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 10:15:55 -0800
Subject: [PATCH 0/3] Few omap2plus_defconfig changes to make more boards usable
Message-ID: <1421691358-14661-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Let's add davinci_emac, and fix the NOR configuration. And let's also
add pcf857x as a loadable module.

Regards,

Tony


Tony Lindgren (3):
  ARM: omap2plus_defconfig: Enable support for davinci_emac
  ARM: omap2plus_defconfig: Enable pcf857x
  ARM: omap2plus_defconfig: Add NOR flash support

 arch/arm/configs/omap2plus_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.1.4
