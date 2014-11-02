From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 02 Nov 2014 07:51:42 +0100
Subject: [PATCH v8 0/9] initial suport for Alphascale ASM9260
In-Reply-To: <20141102021123.GQ3698@titan.lakedaemon.net>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <544D0786.2070401@rempel-privat.de>
 <20141102021123.GQ3698@titan.lakedaemon.net>
Message-ID: <5455D47E.4020904@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.11.2014 um 03:11 schrieb Jason Cooper:
> On Sun, Oct 26, 2014 at 03:39:02PM +0100, Oleksij Rempel wrote:
>> Will it be better to split this patch set?
>>
>> For example:
>> part 1
>>>   ARM: add mach-asm9260
>>>   ARM: add lolevel debug support for asm9260
>> part2
>>>   ARM: irqchip: mxs: prepare driver for HW with different offsets
>>>   ARM: irqchip: mxs: add Alpascale ASM9260 support
>> and all other patches separately.
>>
>> this will reduce review time for you and give some hope for me :D
> 
> I honestly prefer to keep the series together.  The subject lines make
> it clear which parts I need to worry about merging.  The big thing is
> if there are compile-time dependencies between the different subsystems.
> It doesn't look like there are, but if so, just bring it to our
> attention.

Ok, i'll resend updated version against latest arm-soc/for-next.git, or
should i take other branch?


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141102/59825532/attachment.sig>
