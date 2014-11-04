From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 04 Nov 2014 21:27:25 +0100
Subject: [PATCH v2] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <alpine.DEB.2.11.1411042118490.4245@nanos>
References: <20141104130320.GB21210@tiger>
 <1415128357-12054-1-git-send-email-linux@rempel-privat.de>
 <alpine.DEB.2.11.1411042118490.4245@nanos>
Message-ID: <545936AD.5060009@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.11.2014 um 21:20 schrieb Thomas Gleixner:
> On Tue, 4 Nov 2014, Oleksij Rempel wrote:
> 
>> Freescale iMX23/iMX28 and Alphascale ASM9260 have similar
>> interrupt collectors. It makes easy to reuse irq-mxs code for ASM9260.
>> Differences between this devices are fallowing:
>> - different register offsets
>> - different count of intterupt lines per register
>> - ASM9260 don't provide reset bit
>> - ASM9260 don't support FIQ.
> 
> Why is this a monolithic patch again. IIRC it was split into a
> prepatory (imx) and alphascale part earlier. But my memory might trick
> me.

It is not monolithic. first patch is "[PATCH v8 4/9] ARM: irqchip: mxs:
prepare driver for HW with different offsets".
I don't really wont do discus this irq patches now. Please keep
attention on first two, /arch/arm/ patches.

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/3bc513c1/attachment-0001.sig>
