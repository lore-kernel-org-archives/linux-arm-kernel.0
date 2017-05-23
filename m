From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 23 May 2017 05:27:25 +0000
Subject: pxa3xx-nand failing to find device on linux-next
Message-ID: <b36366e358904310aee4970b77f57dba@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm doing some testing on linux-next and I'm finding that my nand flash 
has disappeared.

pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
pxa3xx-nand f10d0000.flash: non-supported command ef
pxa3xx-nand f10d0000.flash: non-supported command ee
pxa3xx-nand f10d0000.flash: non-supported command ef
pxa3xx-nand f10d0000.flash: non-supported command ee
On-die ECC forcefully enabled, not supported
nand: No NAND device found
pxa3xx-nand f10d0000.flash: failed to scan nand at cs 0

This was working around 4.11. I'll try to do some more digging tomorrow 
to narrow down a failure point but I thought I'd send this out now just 
in case it rings any bells.

The board I'm using (DB-88F6820-AMC) is unfortunately out-of tree but it 
should be pretty close to the armada-388-db. I can make my dts available 
if it's helpful.

Thanks,
Chris
