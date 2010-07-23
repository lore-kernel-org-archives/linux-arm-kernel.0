From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 23 Jul 2010 17:17:37 +0300
Subject: [PATCH v5 3/4] Add s3c-adc-battery driver
In-Reply-To: <20100723131833.GA14980@oksana.dev.rtsoft.ru>
References: <1279364224-24525-1-git-send-email-anarsoul@gmail.com>
	<1279364224-24525-4-git-send-email-anarsoul@gmail.com>
	<20100723131833.GA14980@oksana.dev.rtsoft.ru>
Message-ID: <201007231717.46808.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 23 ???? 2010 16:18:33 ????? Anton Vorontsov ???????:
> On Sat, Jul 17, 2010 at 01:57:03PM +0300, Vasily Khoruzhick wrote:
> > s3c-adc-battery is driver for monitoring
> > and charging battery on iPAQ H1930/H1940/RX1950.
> > It depends on s3c-adc driver to get battery voltage and current.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> 
> Applied to battery-2.6.git (for -next) with a few cosmetic
> fixes.

Thanks :)

> If/when Ben comment on this driver, feel free to send fixups
> on top of battery-2.6.git.
> 
> Also, I can take patch 4/4 if Ben ack it.

It depends on 2/4 patch. Btw, I'm going to re-send machine specific patches in 
few hours (I droped rx1950-specific LEDs driver, gpio-leds is used instead).

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100723/7202b48b/attachment.sig>
