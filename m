From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 23 Sep 2016 10:23:17 +0200
Subject: [PATCH V3 RFT 3/5] ARM64: dts: bcm283x: Use dtsi for USB host mode
In-Reply-To: <87zimz821m.fsf@eliezer.anholt.net>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
 <1471792204-21908-4-git-send-email-stefan.wahren@i2se.com>
 <bb073ea3-2f89-4fc5-e3af-2e27c54f221e@i2se.com>
 <1473245956.28663.50.camel@redhat.com>
 <18641a83-ddd7-1689-535a-c5a15b8a54f9@i2se.com>
 <1473257837.28663.80.camel@redhat.com>
 <aeba1434-3903-3ec4-1a94-e5c8229f4e5f@i2se.com>
 <87zimz821m.fsf@eliezer.anholt.net>
Message-ID: <4cda98b0-03a6-f43d-0eee-29b7702eac8c@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.09.2016 um 10:15 schrieb Eric Anholt:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> Am 07.09.2016 um 16:17 schrieb Gerd Hoffmann:
>>>   Hi,
>>>
>>>> ARM: dts: Remove use of skeleton.dtsi from bcm283x.dtsi
>>>> ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from arch=arm
>>> Picked them up.
>>>
>>>> In case of a multiplatform config with following settings the driver
>>>> isn't able to "detect" the role:
>>>>
>>>> CONFIG_USB=y
>>>> CONFIG_USB_OTG=y
>>>> CONFIG_USB_DWC2=y
>>>> CONFIG_USB_DWC2_DUAL_ROLE=y
>>>> CONFIG_USB_PHY=y
>>>> CONFIG_NOP_USB_XCEIV=y
>>>> CONFIG_USB_GADGET=y
>>>> CONFIG_USB_ZERO=y
>>> Configured my kernel that way so the test actually tests something ;)
>>>
>>> And ... everything looks fine.  usb ethernet works, and so does the usb
>>> keyboard.  /proc/device-tree/soc/usb at 7e980000/dr_mode exists and
>>> contains "host".
>>>
>>> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>>>
>> This patch hasn't been merged yet. Is there something wrong?
> I hadn't bumped it back to todo from RFT.  Also, is this a priority
> patch, since submitting merges is a pain? 
No
> Does USB break in some way
> without it?

No. I only want know if this is still in queue and does someone care
about this patch.

Thanks
Stefan
