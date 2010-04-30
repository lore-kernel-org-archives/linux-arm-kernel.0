From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 30 Apr 2010 20:30:12 +0200
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <20100422110025.GC20008@n2100.arm.linux.org.uk>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	<t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	<q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	<20100422110025.GC20008@n2100.arm.linux.org.uk>
Message-ID: <n2k63386a3d1004301130udb419791p7ee48d109ab209b5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/4/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:

>> I'll keep working on getting the PL011 and PL180 DMA tested on the
>> RealView somehow so those can also be accepted.
>
> So has this (which has now been applied to Dan's tree) been tested
> as I asked on Versatile platforms, or do we have something that could
> be incompatible with those platforms?

I tested them on U300 which has an unmodified PL011 block, both with
and without DMA support compiled in. I have tested the Pl180 mods
on the U300 as well, it has a slightly modified PL180 block.
I have no other hardware...

I will try too boot it up in the QEMU emulator, it has an emulated
PL011 atleast that should account for something? I don't think
it emulates the PL180 though. :-(

> I'm basically not acking or applying these patches until something
> along those lines has happened. ?(And unfortunately I don't have the
> resources to apply to this at present.)

I understand this. I will have to try to dig out some ARM reference
design from somewhere, I cannot afford one sadly.

ARM Ltd. people on this list: if you can send me a versatile
machine, mail me in private for post address...

Yours,
Linus Walleij
