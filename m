From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 00:00:44 +0800
Subject: [PATCH v3 0/7] share rtc-sa1100 driver to arch-mmp
Message-ID: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Share rtc-sa1100 driver among arch-sa1100/arch-pxa/arch-mmp.

Changelog:

v3:
1) Remove the register definition from resource in order to build rtc-pxa
and rtc-sa1100 together. Leave hard coded register definiton in rtc-sa1100.
2) Remove the dummy clock definition in rtc-sa1100.
3) Move the clk_prepare_enable() into open() function.

v2:
1) Use DEFINE_RES_*() to define resource in arch-sa1100.
