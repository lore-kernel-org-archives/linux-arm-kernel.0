From: nm@ti.com (Nishanth Menon)
Date: Mon, 06 Apr 2015 08:21:49 -0500
Subject: LDP: next-20150402: twl4030 regression?
Message-ID: <5522886D.5050409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
looks clean, but

https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
seems to have picked up a regression in the regulator driver.

Master looks clean as well

https://github.com/nmenon/kernel-test-logs/blob/v4.0-rc6/omap2plus_defconfig/ldp.txt
