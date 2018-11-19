From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Nov 2018 14:49:40 -0800
Subject: [PATCH V2 0/3] ARM: dts: add Raspberry Pi 3 A+
In-Reply-To: <284795801.25939.1542408211398@email.ionos.de>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
 <87a7m8d8e6.fsf@anholt.net> <284795801.25939.1542408211398@email.ionos.de>
Message-ID: <87zhu4of7f.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 16. November 2018 um 22:23 geschrieben:
>> 
>> 
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>> 
>> > This patch series adds support for the brand new Raspberry Pi 3 A+ .
>> >
>> > Changes in V2:
>> > - add missing Makefile change for arm64
>> >
>> > Stefan Wahren (3):
>> >   dt-bindings: bcm: Add Raspberry Pi 3 A+
>> >   ARM: dts: add Raspberry Pi 3 A+
>> >   arm64: dts: broadcom: Add reference to RPi 3 A+
>> 
>> Looks pretty reasonable, but I couldn't verify any of the contents --
>> the firmware repo doesn't have a DT file for it, and the published
>> schematics don't show most of the GPIO connections (sigh).  How did you
>> write/test this?
>
> i have a Raspberry Pi 3 A+ and the firmware seems to use a runtime
> generated DT. So i dumped the DTS of a 3 A+ and a 3 B+ from
> procfs. Based on the procfs diff i modified the upstream 3B+ source to
> get a 3A+ .

Sounds good to me.  Comparing to the pi3b+, it looks like the changes I
would expect for the board, so the series is:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/d0dde766/attachment.sig>
