From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 15:38:53 +0100
Subject: Armada XP Internal registers
In-Reply-To: <CAFJTrDv_UdSP9hxAgrXa2Z6p1HFK0WnbQO=csKh8-EL9yUEvqQ@mail.gmail.com>
References: <CAFJTrDv_UdSP9hxAgrXa2Z6p1HFK0WnbQO=csKh8-EL9yUEvqQ@mail.gmail.com>
Message-ID: <20131106153853.0564e22e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Wed, 6 Nov 2013 14:31:49 +0000, Matthew Minter wrote:

> Thanks for the clarification regarding this CP15 bit, I saw various
> documentation mentioning it and had assumed it had been implemented. I
> understand the issue now and also understand why there is a difference
> between the easiest solution and the most elegant.

I believe the CP15 bit solution might have showed up in some Marvell
U-Boot versions, since it was part of our plan to use that, but our
plan failed :)

> However now I understand the issue that is no longer a problem, the
> other half of my email was regarding issues I was having booting using
> a certain, seemingly briefly available version of Marvell's Q2 2013
> u-boot which was causing the kernel to read spurious interrupts and a
> particular "Unhandled fault: external abort on non-linefetch" problem
> which would cause the kernel to panic during the boot process, usually
> during PCI initialisation. However it seems that the problem was due
> to a bug in the version of uboot and has now been patched by Marvell
> and was not an issue with the kernel after all. This at least seems to
> be the case as the patched u-boot allows the previously problematic
> kernel's to boot fine.
> 
> Ultimately I think it is a non issue as it was not (to my
> understanding) a kernel issue in the first place, sorry.

Sure, no problem, thanks for getting back to us about this!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
