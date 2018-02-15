From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 15 Feb 2018 14:49:46 +0200
Subject: [PATCH 0/5] clk: ti: add support for dra76x latched clocks
Message-ID: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Certain clock settings on the dra76x SoC need to be latched for them
to be properly programmed to the PRCM. For example, the setting for
the dra76x GMAC DPLL H14 output is programmed via a register under
the system control module, which doesn't get reflected automatically
under the PRCM HW, and the latch bit is provided to synchronize the
setting from SCM towards PRCM.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
