From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jan 2016 17:07:58 +0100
Subject: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <20160103213938.GD22806@verge.net.au> (Simon Horman's message of
 "Mon, 4 Jan 2016 08:39:38 +1100")
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <20151228050147.GE1066@verge.net.au>
 <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
 <20160103213938.GD22806@verge.net.au>
Message-ID: <87lh7wyu8x.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On dim., janv. 03 2016, Simon Horman <horms@verge.net.au> wrote:

> On Mon, Dec 28, 2015 at 11:15:30AM +0100, Geert Uytterhoeven wrote:

>> >> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
>> >> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
>> >>
>> >> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
>> >> arm-soc maintainers take all applicable patches directly, bypassing the
>> >> mvebu and shmobile maintainers?
>> >>
>> >> Thanks for queuing for v4.5!
>> >>
>> >> Geert Uytterhoeven (9):
>> >>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
>> >>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
>> >>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>> >>     node
>> >>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>> >>     node
>> >>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
>> >
>> > Thanks, I have queued up the above "shmobile" patches for v4.6.
>> 
>> I'm afraid v4.6 is too late, leaving all SPI FLASHes broken in v4.5.
>
> Thanks. I'll re-queue them up as fixes for v4.5.

I thought you planned to directly apply them for v4.5 but I did not see
them in the for-next branch of arm-soc. So as Simon I will submit them
as fix for 4.5.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
