From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 02 Nov 2014 20:56:46 +0100
Subject: [PATCH v8 0/9] initial suport for Alphascale ASM9260
In-Reply-To: <20141102183130.GU3698@titan.lakedaemon.net>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <544D0786.2070401@rempel-privat.de>
 <20141102021123.GQ3698@titan.lakedaemon.net>
 <5455D47E.4020904@rempel-privat.de>
 <20141102183130.GU3698@titan.lakedaemon.net>
Message-ID: <54568C7E.6000306@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.11.2014 um 19:31 schrieb Jason Cooper:
> On Sun, Nov 02, 2014 at 07:51:42AM +0100, Oleksij Rempel wrote:
>> Am 02.11.2014 um 03:11 schrieb Jason Cooper:
>>> On Sun, Oct 26, 2014 at 03:39:02PM +0100, Oleksij Rempel wrote:
>>>> Will it be better to split this patch set?
>>>>
>>>> For example:
>>>> part 1
>>>>>   ARM: add mach-asm9260
>>>>>   ARM: add lolevel debug support for asm9260
>>>> part2
>>>>>   ARM: irqchip: mxs: prepare driver for HW with different offsets
>>>>>   ARM: irqchip: mxs: add Alpascale ASM9260 support
>>>> and all other patches separately.
>>>>
>>>> this will reduce review time for you and give some hope for me :D
>>>
>>> I honestly prefer to keep the series together.  The subject lines make
> 
> To be clear, I meant the emails being in the same thread.

can be split in to parts, but should be within this tread?

>>> it clear which parts I need to worry about merging.  The big thing is
>>> if there are compile-time dependencies between the different subsystems.
>>> It doesn't look like there are, but if so, just bring it to our
>>> attention.
>>
>> Ok, i'll resend updated version against latest arm-soc/for-next.git, or
>> should i take other branch?
> 
> In general it's best to base against one of Linus' tags (eg v3.18-rc1)
> and then rebase against something different only if asked.  That'll be
> per subsystem, though.

just notice, arch/arm related patches are ok on arm-soc/master but fail
fail on arm-soc/for-next.git

> Please don't forget to Cc the mach-mxs/ maintainers on the irqchip
> changes.

ok, thx.


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141102/a3d3268d/attachment.sig>
