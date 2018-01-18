From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Thu, 18 Jan 2018 21:31:06 +0300
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <206582731.31195.1516298825692@email.1und1.de>
References: <5d800b63-d45d-d4e4-214c-3ebf602c79e9@orpaltech.com>
 <1059643032.72553.1516136078614@email.1und1.de>
 <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
 <1199109167.10232.1516213158515@email.1und1.de>
 <665b39ed-e42e-4bd5-36ba-65e733089537@orpaltech.com>
 <998321576.11526.1516217542223@email.1und1.de>
 <b094ab76-8a4e-b47b-4266-4c401f62b8ce@orpaltech.com>
 <974305384.15547.1516259017873@email.1und1.de>
 <c578616d-3eb9-0b5c-c4be-1bad0d9052e9@orpaltech.com>
 <fe2e55f8-a048-9973-5274-e16e2732f841@i2se.com>
 <e476d6a3-a397-64a0-d7ad-2fba66fb276e@orpaltech.com>
 <206582731.31195.1516298825692@email.1und1.de>
Message-ID: <35416c80-bd7f-cee3-7491-c03d891ac4da@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan

On 01/18/2018 09:07 PM, Stefan Wahren wrote:
> Hi Sergey,
>
>> Sergey Suloev <ssuloev@orpaltech.com> hat am 18. Januar 2018 um 18:56 geschrieben:
>>
>>
>> Hi, Stefan,
>>
>>
>> no I haven't checked it yet. I'm going to find information about setting
>> it up w/o u-boot since I've never tried it before.
>>
>>
> store the kernel zImage as /boot/kernel7.img
>
> and define the DT within config.txt
>
> device_tree=bcm2837-rpi-3-b.dtb

ok, what I tried:

1) copied dtbs from firmware github repo

2) copied kernel and kernel7 files

3) modified config.txt? to add

device_tree=bcm2710-rpi-3-b.dtb

4) boot successful

5) here is my dmesg https://pastebin.com/CK33EcgD

Thanks
