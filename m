From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 May 2012 13:36:28 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate> <4FB269CB.4080804@gmail.com>
 <20120515164438.22258885@skate>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
Message-ID: <20120516113628.GA14362@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lior

Thanks for the list.

> I'll try to arrange our SoCs (EBU):
> 
> Orion family:
>       Flavors:
>             5082, 5181, 5181L, 5281, 6183, ...
>       Core: ARMv5 compatible (Feroceon and Jolteon)
>       Process: 90nm
>       Directory: mach-orion5x

mach-orion5x also supports 5182, which is not on your list.
  
> Kirkwood family:
>       Flavors:
>       6190, 6192, ...
>           Core: ARMv5 compatible (Gandalf)
>           Process: 65nm
>           Directory: mach-kirkwood
> 
>       6282 a.k.a Kirkwood 55, Armada 300
>       6283 a.k.a Kirkwood 55, Armada 310
>           Core: ARMv5 compatible (Gandalf)
>           Process: 55nm
>           Directory: not in mainline, future plan

mach-kirkwood supports 6180 6190 6192 6281 6282

6180 and 6281 are not on your list.

> 
>       6710 a.k.a Kirkwood 40, Armada 370
>           Core: ARMv7 compatible (PJ4B)
>           Process: 40nm
>           Directory: new code
> 
> Discovery family:
>       Flavors:
>       78100/78200 a.k.a DiscoDuo
>           Core: ARMv5 compatible (Gandalf)
>           Process: 65nm
>           Directory: mach-mv78xx0
> 
>       78230/78260/78460 a.k.a DiscoSMP, Armada XP
>           Core: ARMv7 compatible (PJ4B)
>           Process: 40nm
>           Directory: new code
> 
> Avanta family: (a.k.a Kirkwood 2)
>       Flavors:
>       6560/60, 6530P, 6510
>           Core: ARMv5 compatible (Gandalf)
>           Process: 55nm
>           Directory: no code in mainline yet, future plan
> 
> Dove: (application processor)
>       Flavors:
>       ap510 a.k.a Armada 510
>           Core: ARMv7 compatible (PJ4)
>           Process: 65nm
>           Directory: mach-dove
 
Is there any logic to the names/numbers?

Thanks
	Andrew
