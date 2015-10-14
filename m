From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 14 Oct 2015 16:36:28 +0200
Subject: [PATCH] arm: pxa: raumfeld: make some variables static
In-Reply-To: <561E2063.8030905@zonque.org> (Daniel Mack's message of "Wed, 14
 Oct 2015 11:29:07 +0200")
References: <1444814866-4639-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <561E2063.8030905@zonque.org>
Message-ID: <877fmp4ivn.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> On 10/14/2015 11:27 AM, Uwe Kleine-K?nig wrote:
>> This fixes the following sparse warnings:
>> 
>> 	arch/arm/mach-pxa/raumfeld.c:510:24: warning: symbol 'raumfeld_w1_gpio_device' was not declared. Should it be static?
>> 	arch/arm/mach-pxa/raumfeld.c:632:31: warning: symbol 'raumfeld_spi_platform_data' was not declared. Should it be static?
>> 	arch/arm/mach-pxa/raumfeld.c:851:28: warning: symbol 'audio_va_initdata' was not declared. Should it be static?
>> 	arch/arm/mach-pxa/raumfeld.c:883:28: warning: symbol 'audio_dummy_initdata' was not declared. Should it be static?
>> 	arch/arm/mach-pxa/raumfeld.c:931:28: warning: symbol 'max8660_v6_subdev_data' was not declared. Should it be static?
>> 
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> Acked-by: Daniel Mack <daniel@zonque.org>
Queued into pxa/for-next, thanks.

Cheers.

--
Robert
