From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 24 Nov 2013 12:52:58 +0100
Subject: [PATCHv2] ARM: mvebu: Add Netgear ReadyNAS 2120 board
References: <87ppq5flnb.fsf@natisbad.org>
 <20131124034951.GY29241@titan.lakedaemon.net>
Message-ID: <87y54e819h.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

> On Tue, Nov 12, 2013 at 08:46:48PM +0100, Arnaud Ebalard wrote:
>> 
>> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
>> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
>> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
>> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
>> controllers, G751 temperature sensor) except for:
>> 
>>  - the Intersil ISL12057 I2C RTC Chip,
>>  - the Armada NAND controller.
>> 
>> Support for both of those is currently work in progress and does not
>> prevent boot.
>> 
>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
> ...
>>  arch/arm/boot/dts/Makefile                     |   1 +
>>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 288 +++++++++++++++++++++++++
>>  2 files changed, 289 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
>
> Applied to mvebu/dt

Thanks, Jason. Based on the response to the question raised by Jason
Gunthorpe regarding PHY compatible string [1], I'll keep in mind to send
you a patch at some point (.dts file for RN2120 also has compatible =
"marvell,88e1318s") if needed.

Cheers,

a+

[1]: http://www.spinics.net/lists/arm-kernel/msg288496.html
