From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 11 Jul 2015 15:46:34 +0900
Subject: [PATCH 0/6] mfd: 88pm800: Add 88pm860 device support
In-Reply-To: <559FB482.4020503@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPetR4KkfRVNz_QtVfFnjQ7p455QknErr1gnK9iBYgRY+A@mail.gmail.com>
 <559E6C9A.8090004@linaro.org> <559E6EBA.3020401@linaro.org>
 <CAJKOXPeF6N_=FhBYOYTTxnGgU8GcTrbqthPNU=bXBfo7Db0Lkg@mail.gmail.com>
 <559FB482.4020503@linaro.org>
Message-ID: <CAJKOXPc=S6Dtp0qt5Pqpf=3JDPSjodj7LukAsDJOArQNGcYdfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-10 21:03 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>
>
> On Thursday 09 July 2015 06:58 PM, Krzysztof Kozlowski wrote:
>>
>> 2015-07-09 21:53 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>>>
>>>
>>>
>>> On Thursday 09 July 2015 06:14 PM, Vaibhav Hiremath wrote:
>>>>
>>>>
>>>>
>>>>
>>>> On Thursday 09 July 2015 05:34 PM, Krzysztof Kozlowski wrote:
>>>>>
>>>>>
>>>>> 2015-07-09 20:47 GMT+09:00 Vaibhav Hiremath
>>>>> <vaibhav.hiremath@linaro.org>:
>>>>>>
>>>>>>
>>>>>> 88PM860 falls under 88pm800 family of devices, with some feature
>>>>>> additions, for example, support for dual phase on BUCK1.
>>>>>
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> There are already drivers for 88PM860: mfd, charger and battery. Isn't
>>>>> you duplicating existing code?
>>>>>
>>>>
>>>> Can you please point me to MFD driver for 88PM860 (Not the charger and
>>>> battery, as I treat them subdevice) ???
>>>>
>>>> I do not think 88PM860 MFD driver is supported already. Correct me if I
>>>> am wrong.
>>>>
>>>
>>> If you are referring to 88pm860x driver, then the answer is NO,
>>> as they both are totally different.
>>
>>
>> I am confused... so the driver drivers/mfd/88pm860x-core.c and its
>> child drivers do not support 88pm860 device? They support 88pm860x
>> device which is totally different than 88pm860 device?
>>
>
> Yes, that's correct.
> That's my understanding as well.

Ok, thanks for patient clarification!

Best regards,
Krzysztof
