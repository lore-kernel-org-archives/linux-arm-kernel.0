From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jul 2018 22:44:38 -0700
Subject: [PATCH v5 2/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
In-Reply-To: <20180709164841.14182-3-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
 <20180709164841.14182-3-faiz_abbas@ti.com>
Message-ID: <20180710054438.GE99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180709 16:50]:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver

I'll apply patches 2 to 5 to omap-for-v4.19/ti-sysc. The clock
patch is trivial enough to not have to wait for Tero to be back
online.

And I'll apply the dts changes into omap-for-v4.19/dt-mcan based
on omap-for-v4.19/ti-sysc because of the dependency to the clocks.

Regards,

Tony
