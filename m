From: anish198519851985@gmail.com (anish singh)
Date: Wed, 30 Jan 2013 13:12:58 +0530
Subject: [RFC PATCH 1/2] ARM: kernel: update cpuinfo to print CPU model
 name
In-Reply-To: <5108B532.6000706@ti.com>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
 <1359474865-15408-2-git-send-email-ruslan.bilovol@ti.com>
 <20130129160827.GJ2637@n2100.arm.linux.org.uk>
 <CAB=otbR+MA3NUhxqRdo=w81gz9sTLAsLV5ELcpp77UxizMiaKw@mail.gmail.com>
 <5108B532.6000706@ti.com>
Message-ID: <CAK7N6voqZTfUAGY-UCAMiYYt0oou8vAyO5zmO7gXZhKt2G16vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:22 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 30 January 2013 04:42 AM, Ruslan Bilovol wrote:
>>
>> Hi,
>>
>> On Tue, Jan 29, 2013 at 6:08 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>>
>>> On Tue, Jan 29, 2013 at 05:54:24PM +0200, Ruslan Bilovol wrote:
>>>>
>>>> CPU implementer : 0x41
>>>> CPU name        : OMAP4470 ES1.0 HS
>>>
>>>
>>> Sigh.  No.  Look at what you're doing - look carefully at the above.
>>>
>>> "CPU implementer" - 0x41.  That's A.  For ARM Ltd.  ARM Ltd implemented
Wouldn't it be nice to display the name rather than hex?I think this would have
definitely occurred to Russell but it is still done this way.I think
there would be
a valid reason for this and it would be nice to know that.

If not then I can cook up a patch.

>>> this CPU.  Did ARM Ltd really implement OMAP4470 ?  I think TI would be
>>> very upset if that were to be the case.
>>
>>
>> Yes, it would be very surprisingly :)
>>
>>>
>>> So no, OMAP4470 is _NOT_ a CPU.  It is a SoC.  The CPU inside the SoC is
>>> a collection of ARM Ltd Cortex A9 _CPUs_.
>>>
>>> See?  Please, learn what a CPU is as opposed to a SoC.
>>
>>
>> Completely agree with you. I will fix this
>>
> Thank god you agreed to drop your current approach. Please elaborate
> what you are going to fix and also state what user-space features
> changes from OMAP4460 to OMAP4470.
>
> Regards,
> Santosh
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
