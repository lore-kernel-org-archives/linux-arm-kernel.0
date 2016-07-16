From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 15 Jul 2016 19:18:17 -0700
Subject: [PATCH v2] clk: gxbb: expose CLKID_MMC_PCLK
In-Reply-To: <m28tx23l0h.fsf@baylibre.com>
References: <20160707033837.20029-1-khilman@baylibre.com>
 <146794722863.73491.474750140948566962@resonance>
 <m28tx23l0h.fsf@baylibre.com>
Message-ID: <146863549703.73491.15445512744188633959@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kevin Hilman (2016-07-15 09:48:30)
> Michael Turquette <mturquette@baylibre.com> writes:
> 
> > Quoting Kevin Hilman (2016-07-06 20:38:37)
> >> The MMC_PCLK is needed for the SD/eMMC driver, expose to DT (and comment
> >> out in clk driver)
> >> 
> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> >
> > Applied to the same clk-s905 branch if you need to re-pull it as a
> > dependency.
> 
> Ugh.  Just received some updated documentation, and turns out this clock
> is not used at all. :(
> 
> Feel free to revert now before it becomes ABI.

Reverted.

> 
> Now that I have actual docs, I'll have a new series coming that will
> have the right clock details.

No problem. I did a git revert b/c I don't want to rebase this late in
the cycle.

Regards,
Mike

> 
> Thanks, and sorry for the noise,
> 
> Kevin
