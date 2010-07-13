From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 13 Jul 2010 18:45:04 +0300
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <20100713151310.GA12234@oksana.dev.rtsoft.ru>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<20100713151310.GA12234@oksana.dev.rtsoft.ru>
Message-ID: <201007131845.10426.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 13 ???? 2010 18:13:10 ????? Anton Vorontsov ???????:

> No, please. Factor out LED triggers addition into a separate patch
> and we will discuss* it. That way it won't block this driver merge.

I'm not in hurry :) it's just my hobby, and I really don't care _when_ this 
driver will be merged. But I want it to be merged with all functionality 
(getting status/charging/LEDs).

> * IIRC, using LED_HALF for blinking is wrong, see
>   drivers/leds/leds-pwm.c for a preferred approach.

Then it needs complex trigger, so anyway generic power supply simple triggers 
do not fit in my case. Btw, some LEDs drivers in mainline kernels use LED_HALF 
for blinking, i.e. leds-pca955x.c and leds-h1940.c.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100713/70e2cf95/attachment.sig>
