From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Feb 2015 20:06:36 +0100
Subject: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
Message-ID: <20150224190636.GG7789@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Tue, Feb 24, 2015 at 07:56:52PM +0100, Stefan Wahren wrote:
> After replacing "i" with "priv->num_leds" in this patch we are able to use pwm
> led with trigger heartbeat.
Right, that's what I did in my tree to to please the build robot :-)

> This is the functional part of this issue, since the warning has been fixed [1]
Can I interpret this as an Tested-by: for this patch and an Ack for
patch 1?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
