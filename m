From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Jan 2018 17:55:21 +0100
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <c578616d-3eb9-0b5c-c4be-1bad0d9052e9@orpaltech.com>
References: <5d800b63-d45d-d4e4-214c-3ebf602c79e9@orpaltech.com>
 <1059643032.72553.1516136078614@email.1und1.de>
 <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
 <1199109167.10232.1516213158515@email.1und1.de>
 <665b39ed-e42e-4bd5-36ba-65e733089537@orpaltech.com>
 <998321576.11526.1516217542223@email.1und1.de>
 <b094ab76-8a4e-b47b-4266-4c401f62b8ce@orpaltech.com>
 <974305384.15547.1516259017873@email.1und1.de>
 <c578616d-3eb9-0b5c-c4be-1bad0d9052e9@orpaltech.com>
Message-ID: <fe2e55f8-a048-9973-5274-e16e2732f841@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,


Am 18.01.2018 um 13:55 schrieb Sergey Suloev:
> Hi, Stefan
>
> On 01/18/2018 10:03 AM, Stefan Wahren wrote:
>> Hi Sergey,
>>
>>> Sergey Suloev <ssuloev@orpaltech.com> hat am 17. Januar 2018 um 
>>> 21:04 geschrieben:
>>>
>>>
>>> Hi Stefan,
>>>
>>> I am using u-boot tagged 2018.01.
>> interesting. I don't use u-boot as second stage bootloader. Maybe it 
>> messed up the pin configuration of the GPIO expander. Could you 
>> please try without u-boot?
>
> but how can u-boot influence that ? As far as I understand the error 
> happens in a very late boot stage, actually in the end. At this time 
> bcm2837-rpi-3-b device tree file from kernel is already loaded. Do you 
> think this DTB is incorrect ?

wild guessing doesn't help here. Did you test it without U-Boot? Did the 
issue still occur?

Stefan

>
> Thanks
>
>
