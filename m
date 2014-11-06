From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 06 Nov 2014 23:47:00 +0100
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106084910.GA10432@pengutronix.de>
Message-ID: <87wq78lzff.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Nov 05, 2014 at 10:42:52PM +0100, Arnaud Ebalard wrote:
>> +#ifdef CONFIG_PM_SLEEP
>> +static int isl12057_rtc_suspend(struct device *dev)
>> +{
>> +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
> drivers/rtc/rtc-isl12057.c: In function 'isl12057_rtc_suspend':
> drivers/rtc/rtc-isl12057.c:551:56: error: 'client' undeclared (first
> use in this function)

I guess I forgot to do a git commit after my last quilt refresh before
pushing the patches. Sorry for that.

Cheers,

a+
