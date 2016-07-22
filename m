From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 22 Jul 2016 07:39:22 -0700
Subject: [RCF 1/3] hwmon: Add ads1118 driver
In-Reply-To: <578990A1.6020300@roeck-us.net>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
 <578990A1.6020300@roeck-us.net>
Message-ID: <5792301A.6030206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings Guenter,

Thank you for reviewing my submission.

On 07/15/2016 06:40 PM, Guenter Roeck wrote:
> On 07/15/2016 05:18 PM, Joshua Clayton wrote:
>> Add new driver for Texas Instruments ADS1118 and and ADS1018.
>> This driver works with ADS1018, because of code borrowed
>> from asd1015, which is similar, but I can only test ADS1118
>>
>
> Browsing through the datasheet, I think this should probably be implemented
> as iio driver (and iio already has a driver for ads1015).
>
> Jonathan, what do you think ?
>
> Thanks,
> Guenter
>
No response from Jonathan as yet, but I am willing to rework the driver when I
have some time. It might be weeks before I can start, though.

I am not very familiar with the iio subsystem, (actually had never heard of it before
receiving your response). Learning it might be beneficial, as it looks like a good fit
for an in house driver, which I'd like to eventually upstream.

If an hwmon driver is adequate, I have new patches that address kbuild and endianness
issues in the first version.


~Joshua Clayton
