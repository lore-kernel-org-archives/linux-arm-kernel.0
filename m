From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 09 Jul 2015 17:27:05 +0530
Subject: [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
In-Reply-To: <20150709115533.GY3127@piout.net>
References: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
 <20150709115533.GY3127@piout.net>
Message-ID: <559E6191.3050202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 09 July 2015 05:25 PM, Alexandre Belloni wrote:
> Hi,
>
> On 09/07/2015 at 12:25:51 +0530, Vaibhav Hiremath wrote :
>> Along with DT support, this patch also cleans up the unnecessary
>> code around 'rtc_wakeup' initialization.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> No need to resend, I'll take it. I'm current busy with other things and
> it is still early in the development cycle.
>

Thanks,

And sorry for noise,
I was not so sure about the status, so resent it.


>> -	if (pm80x_pdata) {
>> -		pdata = pm80x_pdata->rtc;
>> -		if (pdata)
>> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
>> -	}
>> +	/* remeber whether this power up is caused by PMIC RTC or not */
>
> I'll fix that typo...
>

Oops. Thankks for noting and correcting it.

Thanks,
Vaibhav
