From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Jan 2018 19:07:05 +0100 (CET)
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <e476d6a3-a397-64a0-d7ad-2fba66fb276e@orpaltech.com>
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
Message-ID: <206582731.31195.1516298825692@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

> Sergey Suloev <ssuloev@orpaltech.com> hat am 18. Januar 2018 um 18:56 geschrieben:
> 
> 
> Hi, Stefan,
> 
> 
> no I haven't checked it yet. I'm going to find information about setting 
> it up w/o u-boot since I've never tried it before.
> 
> 

store the kernel zImage as /boot/kernel7.img

and define the DT within config.txt 

device_tree=bcm2837-rpi-3-b.dtb
