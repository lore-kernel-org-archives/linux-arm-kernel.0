From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 21 Feb 2012 17:04:49 +0800
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
Message-ID: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the hardcode definition of rtc registers, use ioremap() instead.
Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.
