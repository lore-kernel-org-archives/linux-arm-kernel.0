From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 01 Jul 2011 08:41:01 +0300
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC
	controller driver
In-Reply-To: <20110630170432.GA20948@pengutronix.de>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110630102728.GB1997@pengutronix.de>
	<20110630170432.GA20948@pengutronix.de>
Message-ID: <1309498866.23597.201.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-30 at 19:04 +0200, Wolfram Sang wrote:
> Why can't you define a nand_ecclayout with no free space?

Yes, this sounds like the right way to go.

-- 
Best Regards,
Artem Bityutskiy
