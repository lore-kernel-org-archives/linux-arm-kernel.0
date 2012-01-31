From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 31 Jan 2012 13:21:30 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120131114929.GN2471@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <201201311237.33997.marek.vasut@gmail.com>
 <20120131114929.GN2471@pengutronix.de>
Message-ID: <201201311321.30806.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Actually it's not board specific. You can run various bootloaders or
> > various bootstrap tools on any of those boards. Though pdata seems ok
> > for the default case, maybe we should have a simple way to override
> > this?
> 
> You mean you want to switch to/drop the BBT if you want to? On MX23,
> this can be easily a very dangerous thing to do. What's the use case?

Tools that don't support writing the BBT properly.

> 
> Regards,
> 
>    Wolfram
