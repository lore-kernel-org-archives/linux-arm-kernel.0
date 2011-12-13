From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Dec 2011 09:35:56 -0800
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <4EE75E1A.7080101@ti.com> (Rajendra Nayak's message of "Tue, 13
 Dec 2011 19:45:54 +0530")
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <874nxd5j0f.fsf@ti.com> <4EE75E1A.7080101@ti.com>
Message-ID: <87pqfsxtkz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> Hi Kevin,
>
> On Wednesday 07 December 2011 05:51 AM, Kevin Hilman wrote:
>> "Govindraj.R"<govindraj.raja@ti.com>  writes:
>>
>>> Converting uart driver to adapt to pm runtime API's.
>>> Code re-org + cleanup.
>>> Moving some functionality from serial.c to omap-serial.c
>>
>> Alan, can you confirm your Ack's are still valid on the drivers/tty
>> parts of this series?  It has gone through quite a few changes since
>> your original ack.
>>
>> Greg, are you ok with this series merging via the OMAP tree since it is
>> changing arch/arm/mach-omap2/* code as well as the driver, and should go
>> together.  If so, with your ack (on the drivers/tty/* parts), I'll
>> handle this series through the OMAP tree.
>
> I had a series to add DT support for omap-serial, which I did on top
> of the runtime series from Govindraj. Its already acked by Rob Herring
> for the DT parts. Would you be able to pick those up as well if its
> fine with Greg?

Yes, those should go on top of Govindraj's series.

I'm OK with taking them, but I'd like to see them rebased on Govidraj's
latest and see several Tested-by reports from various people since it is
pretty late in the merge cycle.

Kevin
