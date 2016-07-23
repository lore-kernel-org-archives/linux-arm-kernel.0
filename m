From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 22 Jul 2016 18:20:10 -0700
Subject: ADS1118: hwmon or iio ? [was: Re: [RCF 1/3] hwmon: Add ads1118 driver]
In-Reply-To: <5792301A.6030206@gmail.com>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
 <578990A1.6020300@roeck-us.net> <5792301A.6030206@gmail.com>
Message-ID: <5792C64A.3090600@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2016 07:39 AM, Joshua Clayton wrote:
> Greetings Guenter,
>
> Thank you for reviewing my submission.
>
> On 07/15/2016 06:40 PM, Guenter Roeck wrote:
>> On 07/15/2016 05:18 PM, Joshua Clayton wrote:
>>> Add new driver for Texas Instruments ADS1118 and and ADS1018.
>>> This driver works with ADS1018, because of code borrowed
>>> from asd1015, which is similar, but I can only test ADS1118
>>>
>>
>> Browsing through the datasheet, I think this should probably be implemented
>> as iio driver (and iio already has a driver for ads1015).
>>
>> Jonathan, what do you think ?
>>
>> Thanks,
>> Guenter
>>
> No response from Jonathan as yet, but I am willing to rework the driver when I
> have some time. It might be weeks before I can start, though.
>

Changing the subject - maybe it helps to get Jonathan's attention.

Guenter
