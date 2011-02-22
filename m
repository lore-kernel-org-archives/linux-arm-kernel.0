From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 20:56:53 +0100
Subject: [PATCH 5/5] arm: mach-mx3: use IMX_GPIO_NR instead of
	hard-coded values
In-Reply-To: <19811.47706.277301.848103@ipc1.ka-ro>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
	<19811.47706.277301.848103@ipc1.ka-ro>
Message-ID: <20110222195653.GB9046@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  #define GPIO_LCDPWR	(4)
> >  
> While you are at it you could also remove the nonsensical () around
> the bare number.

That would need a seperate patch in my book. I won't bother.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/628cea18/attachment.sig>
