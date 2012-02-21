From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 21 Feb 2012 16:37:06 +0100
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120221153706.GD9371@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:04 Tue 21 Feb     , Haojian Zhuang wrote:
> Remove the hardcode definition of rtc registers, use ioremap() instead.
> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.
looks gine 

Best Regards,
J.
