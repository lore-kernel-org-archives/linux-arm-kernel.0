From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 22:29:09 +0800
Subject: [PATCH] pxa/magician: fix MAGICIAN_EGPIO_BASE,
	align with NR_BUILTIN_GPIO
In-Reply-To: <20110705100355.GS8286@n2100.arm.linux.org.uk>
References: <1303394226.16309.1.camel@flow>
	<CAMPhdO-xQ614Rs-tTEY0v7i6_Q=aNUtoCo3AZ33nc1LsKoTn4w@mail.gmail.com>
	<20110705100355.GS8286@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO9Zh2b=i5qqY01D_PMNwt=-9hqTRJTHvq4pmEPfUFb9-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 6:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 05, 2011 at 03:46:12PM +0800, Eric Miao wrote:
>> On Thu, Apr 21, 2011 at 9:57 PM, Philipp Zabel <pzabel@gmx.de> wrote:
>> > Commit a0a4dcbca73a418477f439e812193e2591b46751
>> > "ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt number"
>> > increased NR_BUILTIN_GPIO from 128 to PXA_GPIO_IRQ_NUM (192).
>> > Adjust the previously hardcoded MAGICIAN_EGPIO_BASE accordingly.
>> >
>> > Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>>
>> Applied.
>>
>> > ---
>> > ?arch/arm/mach-pxa/include/mach/magician.h | ? ?3 ++-
>> > ?1 files changed, 2 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
>> > index 0a2efcf..e9e6162 100644
>> > --- a/arch/arm/mach-pxa/include/mach/magician.h
>> > +++ b/arch/arm/mach-pxa/include/mach/magician.h
>> > @@ -12,6 +12,7 @@
>> > ?#ifndef _MAGICIAN_H_
>> > ?#define _MAGICIAN_H_
>> >
>> > +#include <mach/gpio.h>
>
> Note that there's yet another mach/gpio.h here.
>

Fixed.
