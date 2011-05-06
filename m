From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 6 May 2011 15:49:34 -0600 (MDT)
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Gulati, Shweta wrote:

> Yes, but in current code clk_set_rate of dpll3_m2 -
> 'omap3_core_dpll_m2_set_rate'
> doesn't update clk.rate, I will submit patch fixing that bug and will
> make sure that
> set_rate of all clocks should update clk.rate

Ping.  Do you plan to post this soon?  This should be a trivial patch.

- Paul
