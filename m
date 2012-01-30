From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jan 2012 14:35:20 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130131913.GE15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <201201301324.13962.marek.vasut@gmail.com>
 <20120130131913.GE15596@pengutronix.de>
Message-ID: <201201301435.20237.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The mainline incarnation of this should be able to work with the BBT just
> > fine. You can give it a go, mx28evk (the freescale kit) is supported.
> 
> Did you test? I can't find any NO_OOB option in the code. Not that you
> lose the BBTs...

I didn't. Let's also Cc Fabio here, I think he can comment on the FSL part of 
stuff better than me.

Btw. aren't we duplicating stuff here? The mx28 has some builtin badblock 
protection.
