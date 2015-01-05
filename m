From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 05 Jan 2015 09:50:52 +0000
Subject: [PATCH 0/9] ARM Versatile multi-platform support
In-Reply-To: <CAFEAcA9pKdRNQ-fgKumQhjTjei-4NJ-OB1gSOxTCnCjShy10jw@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CAFEAcA9pKdRNQ-fgKumQhjTjei-4NJ-OB1gSOxTCnCjShy10jw@mail.gmail.com>
Message-ID: <54AA5E7C.1040706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/12/14 09:25, Peter Maydell wrote:
> On 30 December 2014 at 19:28, Rob Herring <robherring2@gmail.com> wrote:
>> This has been tested on QEMU. A previous version was tested on
>> Versatile/AB by Linus Walleij. Linus reported a problem with the
>> display panel detection. Investigation on h/w is needed still as I have
>> not been able to identify the issue by inspection and the display
>> detection seems to work correctly on QEMU.
>>
>> Linus had also mentioned to me that QEMU users may have some issue with
>> removing non-DT code as the work flow has to change somewhat.
> 
> As long as you call out the requirement for a DT now in whatever
> your equivalent of release notes is that should be fine. (Does
> the kernel provide a useful message to serial in the absence of a
> DT or does it now not have enough platform knowledge to do that?)
> 
>> Copying
>> Peter Maydell here for comment (and there's rumors he may have actual PB
>> h/w with PCI as well).
> 
> Will Deacon and Marc Zyngier are currently in possession of that h/w.
> I'm sure they'd be delighted to pull it out of the cupboard and
> give it a spin :-)

I'll try to find some time (or a victim to do the testing... ;-). To
those interested, I have a few extra PCI backplanes (just the PCB, not
the huge noisy carrier rack) I could be convinced to part with...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
