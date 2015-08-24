From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 24 Aug 2015 12:13:34 +0530
Subject: [PATCH-v6 0/6] mfd: 88pm800: Add Device tree support
In-Reply-To: <55A40A32.8060901@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
 <55A40A32.8060901@linaro.org>
Message-ID: <55DABD16.8080309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 14 July 2015 12:27 AM, Vaibhav Hiremath wrote:
>
>
> On Wednesday 08 July 2015 05:56 PM, Vaibhav Hiremath wrote:
>> This patch-series adds support for Device tree to 88PM800 mfd driver.
>> It also sets default configuration of irq clear method if board file
>> doesn't exist.
>>
>> Testing::
>>   - Boot tested on PXA1928 based platform.
>>   - probe of mfd, rtc and regulator function passing successfully.
>>   - Basic read operations on registers
>>   - irq clear configuration
>>
>> V5 => V6
>> =======
>
> I hope this will be queued for 4.2
>


Lee,

This patch-series is pending since long time, reviewed and acked.
Request to queue it up for next merge window.

Thanks,
Vaibhav
