From: eric@anholt.net (Eric Anholt)
Date: Thu, 18 Aug 2016 17:37:56 -0700
Subject: [PATCH V2 RFC 0/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1091535069.365254.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <87lgzuj66o.fsf@eliezer.anholt.net>
 <1091535069.365254.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
Message-ID: <87twehegpn.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 18. August 2016 um 20:14 geschrieben:
>> 
>> 
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>> 
>> > This patch series is only a draft and not intended to be merged. Patches 1
>> > and 2
>> > aren't bcm2835 specific and should be helpful for other platforms. 
>> > The patches 2 - 4 are required for otg / gadget mode. The last patch
>> > based on the work of Lubomir Rintel [1] and Noralf Tr?nnes [2].
>> >
>> > Changes since V1:
>> > - rebase to current linux-next
>> > - add patches 1 - 4 for otg/gadget support
>> > - add patch 5 with model compatible
>> > - use polarity define for ACT LED
>> >
>> > [1] -
>> > http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-February/003221.html
>> > [2] - https://github.com/raspberrypi/linux/pull/1239/
>> >
>> > Stefan Wahren (6):
>> >   usb: dwc2: core: Avoid nonsense error in gadget mode
>> >   usb: dwc2: Add DT properties to specify fifo size in host/otg mode
>> >   ARM: dts: bcm283x: Add missing usb clock
>> >   ARM: dts: bcm283x: Add generic USB PHY
>> >   DT: bindings: bcm: Add Raspberry Pi Zero
>> >   ARM: dts: bcm2835: Add Raspberry Pi Zero
>> 
>> Where are we at on these?  
>
> I would like to split the series:
> part 1: Raspberry Pi Zero support (only USB host mode support)
> part 2: OTG / Peripheral support for BCM2835 (hope that i reach the point)

That sounds great.

>> I've been holding off waiting for the USB
>> bits to get settled.  I can grab the bindings patch, but is there
>> anything else we could merge while you're working on USB?
>
> Maybe i missed something, but i didn't received any ACK from you about this
> series.
>
> In case everything is okay, you could also merge patch 3 since it's relevant to
> bcm283x and not RPi Zero specific.

Didn't miss anything.  I hadn't acked yet since it looked like there
were open questions for the USB folks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160818/72d6d925/attachment-0001.sig>
