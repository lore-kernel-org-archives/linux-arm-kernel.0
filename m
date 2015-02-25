From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 25 Feb 2015 09:13:26 +0100
Subject: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <20150224190636.GG7789@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
 <20150224190636.GG7789@pengutronix.de>
Message-ID: <54ED8426.6090401@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Am 24.02.2015 um 20:06 schrieb Uwe Kleine-K?nig:
> Hello Stefan,
>
> On Tue, Feb 24, 2015 at 07:56:52PM +0100, Stefan Wahren wrote:
>> After replacing "i" with "priv->num_leds" in this patch we are able to use pwm
>> led with trigger heartbeat.
> Right, that's what I did in my tree to to please the build robot :-)

in that case, here is my:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

>> This is the functional part of this issue, since the warning has been fixed [1]
> Can I interpret this as an Tested-by: for this patch and an Ack for
> patch 1?

Sorry, but i don't think i'm the right person for acking patch 1.

Stefan

> Best regards
> Uwe
>
