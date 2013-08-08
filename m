From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Aug 2013 09:27:19 +0100
Subject: __ARM_ARCH_2__
In-Reply-To: <CANEcUBWAYe1Zkes3ZxFr9Copwh-H9Meijg6eupiQaKRUR0Jmdg@mail.gmail.com>
References: <CANEcUBWAYe1Zkes3ZxFr9Copwh-H9Meijg6eupiQaKRUR0Jmdg@mail.gmail.com>
Message-ID: <20130808082719.GH23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 10:08:02AM +0800, zhaobin xv wrote:
> I don't know what the"__ARM_ARCH_2__" mean?
> "__ARM_ARCH_2__" is definded by gcc or definded byarmlinux?
> where does it come from? what does it want to do?

You could try a few things before posting:

1. You could try grepping the kernel source to find out if anything
   in the kernel defines it.
2. You could try asking google and seeing what it returns.

Either of those will tell you that it's not defined by the kernel but by
the compiler.  For me, the first link on google explains it really well.

Thanks.
