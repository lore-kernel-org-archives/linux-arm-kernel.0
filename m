From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 18:58:55 +0200
Subject: Marvell Orion5x boards with PCIe, and DT conversion
In-Reply-To: <5348A96D.7060909@free.fr>
References: <20140411155735.109c5d04@skate> <53480402.5030101@free.fr>
 <5348A96D.7060909@free.fr>
Message-ID: <20140413185855.6e6dd6ac@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Moore,

On Sat, 12 Apr 2014 04:48:13 +0200, Chris Moore wrote:

> I have a Buffalo LinkStation Pro Duo in the cupboard.
> I have never hacked it but I believe it is based on Orion5x.
> If I can find an active serial port on the motherboard, I could test it.

Ah, that would be interesting. This machine is supported by
kurobox_pro-setup.c, but apparently it indeed does not have PCI.
Anyway, I'll try to convert this machine to DT, so if you could test
the result that would be very nice.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
