From: mkl0301@gmail.com (Lin Mac)
Date: Mon, 15 Nov 2010 05:58:42 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <20101112143230.GA8197@n2100.arm.linux.org.uk>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101112143230.GA8197@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimK_MzQCXTwvyFE8sPA=gfz822FN_h4UF5RbnqR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Nov 05, 2010 at 11:08:25AM +0800, Lin Mac wrote:
>> So I tried to enable DEBUG in head.S with following patch:
>> Then it failed at building:
>> ----
>> ? AS ? ? ?arch/arm/boot/compressed/lib1funcs.o
>> arch/arm/boot/compressed/head.S: Assembler messages:
>> arch/arm/boot/compressed/head.S:1019: Error: too many positional arguments
>> arch/arm/boot/compressed/head.S:1036: Error: too many positional arguments
>> make[3]: *** [arch/arm/boot/compressed/head.o] Error 1
> Please do:
> make ARCH=arm CROSS_COMPILE=... arch/arm/boot/compressed/head.s
> and send me (in private mail) a copy of head.s. ?Thanks.
It is fixed. I'll send the patch.

Best Regards,
Mac Lin.
