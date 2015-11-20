From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 20 Nov 2015 10:36:52 +0100
Subject: [PATCH 3/3] leds/pwm: fix driver description and make license
 match the header
In-Reply-To: <20151119191737.GF22022@pengutronix.de>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385412225-29740-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <20151119191737.GF22022@pengutronix.de>
Message-ID: <564EE9B4.3010404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Applied, thanks.

Best Regards,
Jacek Anaszewski

On 11/19/2015 08:17 PM, Uwe Kleine-K?nig wrote:
> Hello,
>
> while the other two patches in this thread are controversal, this one
> shouldn't. It still sits in my branch with unapplied patches since
> nearly two years, which is enormous considering it's such an easy patch.
>
> Best regards
> Uwe
>
> On Mon, Nov 25, 2013 at 09:43:45PM +0100, Uwe Kleine-K?nig wrote:
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> ---
>>   drivers/leds/leds-pwm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
>> index cdc3e4d..0796ca3 100644
>> --- a/drivers/leds/leds-pwm.c
>> +++ b/drivers/leds/leds-pwm.c
>> @@ -239,6 +239,6 @@ static struct platform_driver led_pwm_driver = {
>>   module_platform_driver(led_pwm_driver);
>>
>>   MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>> -MODULE_DESCRIPTION("PWM LED driver for PXA");
>> -MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("generic PWM LED driver");
>> +MODULE_LICENSE("GPL v2");
>>   MODULE_ALIAS("platform:leds-pwm");
>> --
>> 1.8.4.2
>>
>>
>
