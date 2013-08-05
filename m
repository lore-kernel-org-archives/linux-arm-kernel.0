From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 05 Aug 2013 20:35:34 +0200
Subject: [PATCHv1] arm: armada: Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130805134457.GH19280@titan.lakedaemon.net> (Jason Cooper's
 message of "Mon, 5 Aug 2013 09:44:57 -0400")
References: <878v1mgh4x.fsf@natisbad.org> <51FFA7C1.1050103@free-electrons.com>
 <20130805134457.GH19280@titan.lakedaemon.net>
Message-ID: <87bo5cdlzd.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason and Gregory,

Jason Cooper <jason@lakedaemon.net> writes:

> On Mon, Aug 05, 2013 at 03:25:21PM +0200, Gregory CLEMENT wrote:
>> On 04/07/2013 23:16, Arnaud Ebalard wrote:
>> > 
>> > All hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 102 are
>> > supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
>> > Gigabit controller and PHY, serial port, leds, buttons, SATA ports,
>> > G762 fan controller) except for:
>> > 
>> >  - the Intersil ISL12057 I2C RTC Chip,
>> >  - the Armada NAND controller.
>> > 
>> > Support for both of those is currently work in progress and does not
>> > prevent boot.
>> 
>> If it is not too late you can add my
>> 
>> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Added.
>
>> Just a nitpick:
>> 
>> For a better coherency in your file you could add an extra line before
>> each sub-node as you have done for all the other nodes:
>
> fixed.

Thank you guys for resurrecting the thread. I was kind of waiting some
more days for some feedback on ISL 12057 RTC chip driver from rtc-linux
group. It now seems unlikely the driver will be in 3.12 so let's leave
the .dts as is. I'll push an update for the .dts file to reference the
device for 3.13-rc* cycle.

Cheers,

a+
