From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 09 Jul 2015 18:23:14 +0530
Subject: [PATCH 0/6] mfd: 88pm800: Add 88pm860 device support
In-Reply-To: <559E6C9A.8090004@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPetR4KkfRVNz_QtVfFnjQ7p455QknErr1gnK9iBYgRY+A@mail.gmail.com>
 <559E6C9A.8090004@linaro.org>
Message-ID: <559E6EBA.3020401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 09 July 2015 06:14 PM, Vaibhav Hiremath wrote:
>
>
> On Thursday 09 July 2015 05:34 PM, Krzysztof Kozlowski wrote:
>> 2015-07-09 20:47 GMT+09:00 Vaibhav Hiremath
>> <vaibhav.hiremath@linaro.org>:
>>> 88PM860 falls under 88pm800 family of devices, with some feature
>>> additions, for example, support for dual phase on BUCK1.
>>
>> Hi,
>>
>> There are already drivers for 88PM860: mfd, charger and battery. Isn't
>> you duplicating existing code?
>>
>
> Can you please point me to MFD driver for 88PM860 (Not the charger and
> battery, as I treat them subdevice) ???
>
> I do not think 88PM860 MFD driver is supported already. Correct me if I
> am wrong.
>

If you are referring to 88pm860x driver, then the answer is NO,
as they both are totally different.

Thanks,
Vaibhav
