From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 23 Apr 2011 11:00:21 -0600 (MDT)
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1104231059050.6742@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Gulati, Shweta wrote:

> Yes, but in current code clk_set_rate of dpll3_m2 - 
> 'omap3_core_dpll_m2_set_rate' doesn't update clk.rate, I will submit 
> patch fixing that bug and will make sure that set_rate of all clocks 
> should update clk.rate

Yes, that's the right thing to do, please send that.  Such a patch was 
originally part of the series for the last merge window; it seems I 
inadvertently dropped it.


- Paul
