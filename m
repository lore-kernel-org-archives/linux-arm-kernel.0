From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 16:05:52 -0500
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <56142C74.4010002@free.fr>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <56138485.4090600@free.fr>
 <20151006193815.GI12338@codeaurora.org> <56142C74.4010002@free.fr>
Message-ID: <87h9m31zdb.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Mason <slash.tmp@free.fr> writes:
> Stephen Boyd wrote:
>
>> Mason wrote:
>>
>>> Did you see my "twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally"
>>> patch? What should I do now for it to be accepted?
>> 
>> Assuming you sent it to the correct maintainer from the
>> MAINTAINERS file, I would expect them to apply it directly.
>
> <confused>
>
> The patch touches arch/arm/kernel/smp_twd.c
> I do not see any entry for arch/arm/kernel in MAINTAINERS.
> This means I should fall back to the generic arch/arm entry, right?
>
> ARM PORT
> M:	Russell King <linux@arm.linux.org.uk>
> L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> W:	http://www.arm.linux.org.uk/
> S:	Maintained
> F:	arch/arm/
>
> AFAIU, there is a separate process for submitting patches for arch/arm:
> http://www.arm.linux.org.uk/developer/patches/
>
> Russell, Mark Rutland wrote: "Otherwise this looks ok."
> Does that mean I should now submit via the web form?

Mason, please have a read at Russell's patch info [1]. You don't even
need to use the web form.

[1] http://www.arm.linux.org.uk/developer/patches/info.php

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/0580d2ad/attachment.sig>
