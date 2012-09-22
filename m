From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 22 Sep 2012 13:41:28 +0200
Subject: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
In-Reply-To: <20120921094855.GC15609@n2100.arm.linux.org.uk> (Russell King's
 message of "Fri, 21 Sep 2012 10:48:55 +0100")
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
 <CAMPhdO_xqpqUUbSvi1zC4eT6vr0xFO-70+ieknjMWk9h0iWfHg@mail.gmail.com>
 <20120921094855.GC15609@n2100.arm.linux.org.uk>
Message-ID: <m3haqqthcn.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> > --- a/arch/arm/mach-ixp4xx/include/mach/udc.h
>> > +++ b/arch/arm/mach-ixp4xx/include/mach/udc.h
>> > @@ -2,7 +2,7 @@
>> >   * arch/arm/mach-ixp4xx/include/mach/udc.h
>> >   *
>> >   */
>> > -#include <asm/mach/udc_pxa2xx.h>
>> > +#include <linux/platform_data_pxa2xx_udc.h>
>> 
>> Guess a typo here, "/" instead of "_"? Otherwise looks good to me
>
> Yea, fixed.

The ixp4xx part looks good to me too.
Acked-by: Krzysztof Halasa <khc@pm.waw.pl>

-- 
Krzysztof Ha?asa
