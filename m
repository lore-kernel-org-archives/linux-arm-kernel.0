From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 13 Jul 2010 20:05:45 +0300
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <20100713155811.GA29710@sirena.org.uk>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<201007131845.10426.anarsoul@gmail.com>
	<20100713155811.GA29710@sirena.org.uk>
Message-ID: <201007132005.50412.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 13 ???? 2010 18:58:12 ????? Mark Brown ???????:
> Are you sure that those drivers are actually blinking?  The code makes
> it look like at least pca955x is using PWM to provide brightness control
> rather than actually blinking at a human visible rate.

As for h1940 driver - I'm sure,
for pca955x I was wrong, it just sets brightness (it uses PWM0 for LED_HALF 
value).

Btw, does any driver in kernel uses ledtrig-timer? I don't understand how to 
use it from driver :\

One more thing: on rx1950 (and on h1940) it's impossible to set blink 
duty/period, is it really necessary to define blink_set callback in LEDs 
driver instead of blinking on LED_HALF?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100713/9204de6a/attachment-0001.sig>
