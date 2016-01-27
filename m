From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jan 2016 08:46:07 +0100
Subject: Problem with Allwinner H3 clocks
Message-ID: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

My H3 machine (OPI2) cannot boot with the PLL6 (periph0) as defined
in the kernel 4.5-rc1. As there is no UART, I don't know what is wrong.

But, applying your old patch

[PATCH v4 1/6] clk: sunxi: Let divs clocks read the base factor clock name from devicetree
(https://lkml.org/lkml/2015/10/27/532)

makes everything work correctly again (thanks to other patches, I have
4 CPUs, USB, thermal sensor and video).

Any idea?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
