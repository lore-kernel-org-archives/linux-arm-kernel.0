From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 09 Sep 2016 18:20:54 +0200
Subject: [PATCH 8/8] ARM: pxa/lubbock: add pcmcia clock
In-Reply-To: <20160907091027.GI1041@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 7 Sep 2016 10:10:27 +0100")
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
 <E1bhJNx-0008DR-2l@rmk-PC.armlinux.org.uk>
 <87a8flhrsa.fsf@belgarion.home>
 <20160907091027.GI1041@n2100.armlinux.org.uk>
Message-ID: <871t0thwnt.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Tue, Sep 06, 2016 at 07:17:09PM +0200, Robert Jarzmik wrote:
>> Russell King <rmk+kernel@armlinux.org.uk> writes:
>> 
>> > Add the required PCMCIA clock for the SA1111 "1800" device.  This clock
>> > is used to compute timing information for the PCMCIA interface in the
>> > SoC device, rather than the SA1111.  Hence, the provision of this clock
>> > is a convenience for the driver and does not reflect the hardware, so
>> > this must not be copied into DT.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> But more importantly:
>> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Thanks Robert.  I guess no one else is be interested in these patches,
> so I'm going to drop them into -next today, and send them on Friday or
> over this weekend.

Great !!!!

I'll keep the irq_get_chip() workaround in my private tree for now so that my
automated testing farm can also test the compact flash card. And yes, /dev/hda1
appeared on my lubbock, with a good old MSDOS filesystem :))))

Thanks for the time taken for explanations, I appreciated.

Cheers.

-- 
Robert
