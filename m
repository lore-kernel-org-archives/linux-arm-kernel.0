From: tony@atomide.com (Tony Lindgren)
Date: Fri,  2 Mar 2018 09:32:16 -0800
Subject: [PATCH 0/3] Update multi_v7_defconfig for USB OTG and PHYs
Message-ID: <20180302173219.46112-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like we don't have USB OTG, MUSB and PHYs configured and this
prevents me from running my USB and PM tests with multi_v7_defconfig
out of the box. Let's enable those options as loadable modules.

Regards,

Tony


Tony Lindgren (3):
  ARM: multi_v7_defconfig: Enable OTG and MUSB as loadable modules
  ARM: multi_v7_defconfig: Enable various USB PHYs found on omap
    variants
  ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module

 arch/arm/configs/multi_v7_defconfig | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.16.2
