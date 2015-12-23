From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Dec 2015 12:07:12 +0100
Subject: [PATCH v2 1/9] ARM: mvebu: ix4-300d: Add compatible property to
 "partitions" node
In-Reply-To: <20151222212225.GE30172@localhost> (Olof Johansson's message of
 "Tue, 22 Dec 2015 13:22:25 -0800")
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-2-git-send-email-geert+renesas@glider.be>
 <87zix3rbm7.fsf@free-electrons.com> <20151222212225.GE30172@localhost>
Message-ID: <87a8p1fmov.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On mar., d?c. 22 2015, Olof Johansson <olof@lixom.net> wrote:

> On Mon, Dec 21, 2015 at 05:48:48PM +0100, Gregory CLEMENT wrote:
>> Hi Geert,
>>  
>>  On lun., d??c. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> 
>> > As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> > property to "partitions" node"), the "partitions" subnode of an SPI
>> > FLASH device node must have a compatible property. The partitions are no
>> > longer detected if it is not present.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > Acked-by: Brian Norris <computersforpeace@gmail.com>
>> 
>> Applied on mvebu/dt (with the hope that it is still time to push it to
>> arm-soc)
>
> I think we should just take this directly, so feel free to drop it. I'll
> followup on 0/9.

OK I will drop it of my mvebu/dt and for-next branches.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
