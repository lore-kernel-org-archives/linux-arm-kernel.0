From: david.wu@rock-chips.com (David Wu)
Date: Thu, 14 Jun 2018 16:14:31 +0800
Subject: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
In-Reply-To: <1961033.25ax7s0Z5i@diego>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <1961033.25ax7s0Z5i@diego>
Message-ID: <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2018?06?14? 15:54, Heiko St?bner ??:
> I don't see that new clock documented in the dt-binding.
> Also, which clock from the clock-controller does this connect to?

The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could 
be set rate by the link speed.
