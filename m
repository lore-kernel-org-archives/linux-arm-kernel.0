From: pmeerw@pmeerw.net (Peter Meerwald-Stadler)
Date: Wed, 6 Jul 2016 23:17:07 +0200 (CEST)
Subject: sama5d4, configure pck1 with dt?
Message-ID: <alpine.DEB.2.02.1607062239210.12243@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

how do I configure pck1 using devicetree to be used as the master 
clock for an audio codec?

in particular how do I choose the clock source and frequency for pck1?
is there a way to do this using devicetree?

or is the code in at91sam9g20ek_audio_probe() the way to go?
i.e mclk=clk_get(0, "pck1"); pllb=clk_get(0, "pllb"); clk_set_parent(mclk, 
pllb); clk_set_rate(mclk, 12000000);

confused...

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
