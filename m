From: marex@denx.de (Marek Vasut)
Date: Tue, 28 Aug 2018 12:00:35 +0200
Subject: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
 socfpga_cyclone5_de0_nano_soc.dts
Message-ID: <fd0f01e5-41a2-6a24-2ce4-482b30b348b6@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was recently experimenting with the DE0 Nano SoC / Atlas SoC . I had a
hard time finding the right DT for the board, but then was suggested
that the DT for the board is socfpga_cyclone5_de0_sockit.dts . This did
not make sense to me, since SoCKit is a different board altogether. But
the DTS seems to be indeed for the DE0 Nano SoC.

To fix up this confusion, I'd propose renaming of the
socfpga_cyclone5_de0_sockit.dts to socfpga_cyclone5_de0_nano_soc.dts to
match the label on the package .

What do you think ?

-- 
Best regards,
Marek Vasut
