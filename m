From: moore@free.fr (Chris Moore)
Date: Sat, 12 Apr 2014 04:48:13 +0200
Subject: Marvell Orion5x boards with PCIe, and DT conversion
In-Reply-To: <53480402.5030101@free.fr>
References: <20140411155735.109c5d04@skate> <53480402.5030101@free.fr>
Message-ID: <5348A96D.7060909@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Le 11/04/2014 17:02, Albert ARIBAUD a ?crit :
> Le 11/04/2014 15:57, Thomas Petazzoni a ?crit :
>>
>> I am contacting you because you are all maintainers/contributors to
>> Marvell Orion5x boards supported in the Linux kernel.
>>
>> I am currently converting the mach-orion5x to the Device Tree. I have
>> two Orion5x boards, so I was able to test most of the interfaces myself.
>>
>> However, one interface I'm not able to test is the PCI Express one, and
>> therefore I wanted to let you know if one of you still has a working
>> Orion5x board that has a PCI Express interface that is actually usable.
>>
>> Note that Orion5x SOCs have both a classical PCI interface and a PCI
>> Express interface. On one of my board, I have the classical PCI
>> interface, so I can easily test this. However, I don't have a board
>> with the PCI Express interface.
>>
>> Moreover, I will be sending in the near future a set of patches
>> converting many of the boards to the Device Tree, so if you still have
>> those boards and are willing to test the conversion, it would be very
>> useful.
>
> I'll gladly test these patches on my faithful Orion ED Mini V2. Not 
> sure if it uses PCIe, but I suspect it does not.
>
> How does this play out with U-Boot? I mean, I know that you can 
> produce a kernel which embeds the device tree and will load without 
> U-Boot knowing anything about them, but OTOH, U-Boot has some support 
> for DTs, and could possibly use the DT files too.
>

I have a Buffalo LinkStation Pro Duo in the cupboard.
I have never hacked it but I believe it is based on Orion5x.
If I can find an active serial port on the motherboard, I could test it.

Like Albert, I also have a LaCie EDmini V2, but he, being a U-Boot 
expert and more familiar with DT, is probably better qualified to test it.

Unfortunately I am pretty sure that neither uses a PCI or PCIe bus.

Cheers,
Chris
