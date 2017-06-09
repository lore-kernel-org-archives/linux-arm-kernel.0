From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Jun 2017 09:05:37 +0200
Subject: [PATCH 0/4] ARM: dts: bcm2835-rpi-zero: Enable OTG mode
In-Reply-To: <542130487.90500.1496306283902@email.1und1.de>
References: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
 <542130487.90500.1496306283902@email.1und1.de>
Message-ID: <6a45fcd8-0d88-bc17-6432-d38fe771dc80@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.06.2017 um 10:38 schrieb Stefan Wahren:
>> Stefan Wahren <stefan.wahren@i2se.com> hat am 21. Mai 2017 um 18:44 geschrieben:
>>
>>
>> This patch series enable OTG mode for Raspberry Pi Zero because dwc2 driver
>> has been fixed now.
>>
>> Patch 1 adds a new dtsi file to setup OTG mode (could also be used for boards
>> like RPi Zero W or the Compute Module). The second patch adds the USB PHY and
>> was part of Raspberry Pi Zero support patch series before split up [1].
>> The enabling of OTG mode of RPi Zero is done by patch number 3. The last patch
>> updates the BCM2835 defconfig.
>>
>> [1] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-July/004153.html
>>
>> Stefan Wahren (4):
>>   ARM: dts: bcm283x: Add dtsi for OTG mode
>>   ARM: dts: bcm283x: Add generic USB PHY
>>   ARM: dts: bcm2835-rpi-zero: Enable OTG mode
>>   ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support
>>
> No comments to this patch series?
>
> Regards
> Stefan

@Eric

Should i merge them?
