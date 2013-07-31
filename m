From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 31 Jul 2013 11:51:08 +0200
Subject: NSA310 + DT
In-Reply-To: <51F8DC3A.6010007@uni-bremen.de>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate> <20130731111414.47e7670b@skate>
 <51F8DC3A.6010007@uni-bremen.de>
Message-ID: <20130731115108.21c043fd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Finn Hoffmann,

On Wed, 31 Jul 2013 11:43:22 +0200, Finn Hoffmann wrote:

> Hi Thomas,
> here you are.
> Network is working.

Excellent, thanks!

> # cat /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap
> 0000000000010000) [01] disabled
> [02] disabled
> [03] disabled
> [04] 00000000f4000000 - 00000000f4010000 : nand
> [05] 00000000f5000000 - 00000000f5010000 : sram
> [06] 00000000e0000000 - 00000000e0100000 : pcie0.0
> [07] disabled

Now this looks good, we have both the PCIe memory and PCIe I/O windows
created.

I'll clean up the patch and send it, hopefully for the final 3.11.

Thanks again for all your testing!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
