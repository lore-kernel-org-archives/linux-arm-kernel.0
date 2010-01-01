From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 1 Jan 2010 11:18:01 +0800
Subject: arm-unknown-linux-gnu-ld: no machine record defined
In-Reply-To: <20091231182747.ea8986e6.kristoffer.ericson@gmail.com>
References: <20091231113648.c438503d.kristoffer.ericson@gmail.com>
	<e68bb3470912310519q66a40fbcm15d85a0a5ed19a2f@mail.gmail.com>
	<20091231182747.ea8986e6.kristoffer.ericson@gmail.com>
Message-ID: <e68bb3470912311918v7171a8eap707c5aa65fa46bf1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/1 Kristoffer Ericson <kristoffer.ericson@gmail.com>:
> On Thu, 31 Dec 2009 21:19:54 +0800
> Wan ZongShun <mcuos.com@gmail.com> wrote:
>
>> 2009/12/31 Kristoffer Ericson <kristoffer.ericson@gmail.com>:
>> > Greetings,
>> >
>> > Im adding support for the Dell AXIM X30. Ive created the machine file with relevant makefile/Kconfig option
>> > and everything compiles nicely up to the linker that spits out no machine record defined.
>> >
>> > Kconfig contains
>> > config MACH_X30
>> > ? ? ? bool "AximX30 platform"
>> > ? ? ? select PXA27x
>> > ? ? ? select IWMMXT
>> > ? ? ? select PXA_HAVE_BOARDS_IRQ
>> >
>>
>> Please make sure above definition was really included in your current
>> system at compiling time.
>>
>
> Ive made distclean/clean and recompiled numerous times and getting exactly same
> problem. So must be something else.
>

Would ou please send more info? such as error log,
arch/arm/kconfig,arch/arm/mach-xxx/kcondig?

>>
>> > and aximx30.c got
>> > MACHINE_START(X30, "Axim X30")
>> > .......
>> >
>> >
>> > Shouldnt that be enough for it to find the machine record?
>> >
>> > mach-types got
>> > X30 ? ? MACH_X30 ? ? ? ?X30 ? ? 655
>> >
>> > Maybe im using too old toolchain? Using gcc-3.4.5 + glibc 2.3.5
>> >
>> > Best wishes
>> > Kristoffer Ericson
>> > --
>> > Kristoffer Ericson <kristoffer.ericson@gmail.com>
>> >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> >
>>
>>
>>
>> --
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> --
> Kristoffer Ericson <kristoffer.ericson@gmail.com>
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
