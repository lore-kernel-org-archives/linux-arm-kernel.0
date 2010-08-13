From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 13 Aug 2010 17:09:33 +0800
Subject: [PATCH] ARM: pxa/pwm: Make id const in pwm_probe()
In-Reply-To: <20100813084601.GA27637@pengutronix.de>
References: <1281593908-30448-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTinQK3pddET6eL=JR2aOY4eXTjgO4NFy63JhZo_o@mail.gmail.com>
	<20100813084601.GA27637@pengutronix.de>
Message-ID: <AANLkTi=8EODc8vJu4LyDAP8KXx4Hm5AywHdDtxAPcqRK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/13 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Thu, Aug 12, 2010 at 04:36:57PM +0800, Eric Miao wrote:
>> 2010/8/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > This fixes the compiler warning:
>> >
>> > ? ? ? ?arch/arm/plat-pxa/pwm.c: In function 'pwm_probe':
>> > ? ? ? ?arch/arm/plat-pxa/pwm.c:179: warning: initialization discards qualifiers from pointer target type
>> >
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Ack.
> That means patch system?
>

Nah, I'll merge it later.

> Thanks
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
