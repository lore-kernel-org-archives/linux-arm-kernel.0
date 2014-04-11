From: albert.aribaud@free.fr (Albert ARIBAUD)
Date: Fri, 11 Apr 2014 17:02:26 +0200
Subject: Marvell Orion5x boards with PCIe, and DT conversion
In-Reply-To: <20140411155735.109c5d04@skate>
References: <20140411155735.109c5d04@skate>
Message-ID: <53480402.5030101@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/04/2014 15:57, Thomas Petazzoni a ?crit :
> Hello all,
>
> I am contacting you because you are all maintainers/contributors to
> Marvell Orion5x boards supported in the Linux kernel.
>
> I am currently converting the mach-orion5x to the Device Tree. I have
> two Orion5x boards, so I was able to test most of the interfaces myself.
>
> However, one interface I'm not able to test is the PCI Express one, and
> therefore I wanted to let you know if one of you still has a working
> Orion5x board that has a PCI Express interface that is actually usable.
>
> Note that Orion5x SOCs have both a classical PCI interface and a PCI
> Express interface. On one of my board, I have the classical PCI
> interface, so I can easily test this. However, I don't have a board
> with the PCI Express interface.
>
> Moreover, I will be sending in the near future a set of patches
> converting many of the boards to the Device Tree, so if you still have
> those boards and are willing to test the conversion, it would be very
> useful.

Hi Thomas,

I'll gladly test these patches on my faithful Orion ED Mini V2. Not sure 
if it uses PCIe, but I suspect it does not.

How does this play out with U-Boot? I mean, I know that you can produce 
a kernel which embeds the device tree and will load without U-Boot 
knowing anything about them, but OTOH, U-Boot has some support for DTs, 
and could possibly use the DT files too.

> Thanks a lot,
>
> Thomas

Thanks to you!

Amicalement,
-- 
Albert.
