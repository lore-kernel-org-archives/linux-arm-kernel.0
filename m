From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 11 Apr 2014 15:57:35 +0200
Subject: Marvell Orion5x boards with PCIe, and DT conversion
Message-ID: <20140411155735.109c5d04@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am contacting you because you are all maintainers/contributors to
Marvell Orion5x boards supported in the Linux kernel.

I am currently converting the mach-orion5x to the Device Tree. I have
two Orion5x boards, so I was able to test most of the interfaces myself.

However, one interface I'm not able to test is the PCI Express one, and
therefore I wanted to let you know if one of you still has a working
Orion5x board that has a PCI Express interface that is actually usable.

Note that Orion5x SOCs have both a classical PCI interface and a PCI
Express interface. On one of my board, I have the classical PCI
interface, so I can easily test this. However, I don't have a board
with the PCI Express interface.

Moreover, I will be sending in the near future a set of patches
converting many of the boards to the Device Tree, so if you still have
those boards and are willing to test the conversion, it would be very
useful.

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
