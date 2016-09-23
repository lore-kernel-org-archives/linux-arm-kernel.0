From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 23 Sep 2016 09:33:22 +0200
Subject: [PATCH V3 RFT 3/5] ARM64: dts: bcm283x: Use dtsi for USB host mode
In-Reply-To: <1473257837.28663.80.camel@redhat.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-4-git-send-email-stefan.wahren@i2se.com>
 <bb073ea3-2f89-4fc5-e3af-2e27c54f221e@i2se.com>
 <1473245956.28663.50.camel@redhat.com>
 <18641a83-ddd7-1689-535a-c5a15b8a54f9@i2se.com>
 <1473257837.28663.80.camel@redhat.com>
Message-ID: <aeba1434-3903-3ec4-1a94-e5c8229f4e5f@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.09.2016 um 16:17 schrieb Gerd Hoffmann:
>   Hi,
>
>> ARM: dts: Remove use of skeleton.dtsi from bcm283x.dtsi
>> ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from arch=arm
> Picked them up.
>
>> In case of a multiplatform config with following settings the driver
>> isn't able to "detect" the role:
>>
>> CONFIG_USB=y
>> CONFIG_USB_OTG=y
>> CONFIG_USB_DWC2=y
>> CONFIG_USB_DWC2_DUAL_ROLE=y
>> CONFIG_USB_PHY=y
>> CONFIG_NOP_USB_XCEIV=y
>> CONFIG_USB_GADGET=y
>> CONFIG_USB_ZERO=y
> Configured my kernel that way so the test actually tests something ;)
>
> And ... everything looks fine.  usb ethernet works, and so does the usb
> keyboard.  /proc/device-tree/soc/usb at 7e980000/dr_mode exists and
> contains "host".
>
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>

This patch hasn't been merged yet. Is there something wrong?

Stefan
