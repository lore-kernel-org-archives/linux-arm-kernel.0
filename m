From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Feb 2010 08:04:57 +0200
Subject: [PATCH v2] imxfb: add support for i.MX25
In-Reply-To: <20100210162942.GA15883@pengutronix.de>
References: <20100210082654.GC10185@pengutronix.de>
	<4a9d6157ec463ea6142ab6cc20dac0a6eb761fc7.1265806123.git.baruch@tkos.co.il>
	<20100210162942.GA15883@pengutronix.de>
Message-ID: <20100211060457.GA10514@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Feb 10, 2010 at 05:29:42PM +0100, Uwe Kleine-K?nig wrote:
> did you verify that dropping "FB" works correctly?

No, I didn't, and it doesn't. The "endmenu" at the end of 
drivers/video/Kconfig ends the "menu" block, not the "menuconfig" block, which 
does not require an explicit block end statement. So, the FB dependency is 
required. I'll post an updated patch shortly.

> Other than that
> 
> 	Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for your review, comments, and ack.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
