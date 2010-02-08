From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 8 Feb 2010 11:37:24 +0200
Subject: [PATCH 1/3] gpiolib: make names array and its values const
In-Reply-To: <1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
	<1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100208093724.GA13019@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Feb 08, 2010 at 10:09:38AM +0100, Uwe Kleine-K?nig wrote:
> gpiolib doesn't need to modify the names and I assume most initializers
> use sting constants that shouldn't be modified anyhow.

s/sting/string/

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Kevin Wells <kevin.wells@nxp.com>
> ---

[snip]

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
