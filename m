From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 14:20:05 +0800
Subject: Common clock API for i.MX
In-Reply-To: <20120125084533.GD1068@n2100.arm.linux.org.uk>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
 <20120125084533.GD1068@n2100.arm.linux.org.uk>
Message-ID: <20120126062004.GB2287@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 08:45:33AM +0000, Russell King - ARM Linux wrote:
> Grepping for clk_prepare() it looks like very few people have converted
> over to this - it's just the AMBA stuff, a few bits of OMAP and MXS.

Sascha queued up some of IMX clk_prepare() bits from Richard Zhao on
branch below.

http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/imx-features

Sascha, what's the plan of mainlining them?  I thought you could have
sent them during 3.3 merge window.  But you did not.

-- 
Regards,
Shawn
