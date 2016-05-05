From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 May 2016 21:55:26 +0200
Subject: ARM: SoC fixes for 4.6
In-Reply-To: <7856724.NgjOiORdJx@wuerfel>
References: <7856724.NgjOiORdJx@wuerfel>
Message-ID: <4480155.1AKdzJLtY3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 21:36:43 Arnd Bergmann wrote:
> Here are a couple last-minute fixes for ARM SoCs. Most of them
> are for the OMAP platforms, quoting Tony Lindgren:
> 
>     Fixes for omaps for v4.6-rc cycle. All dts fixes, mostly
>     affecting voltages and pinctrl for various device drivers:
> 
>     - Regulator minimum voltage fixes for omap5
>     - ISP syscon register offset fix for omap3
>     - Fix regulator initial modes for n900
>     - Fix omap5 pinctrl wkup instance size
> 

Sorry for forgetting the [GIT PULL] again on both my pull requests, I'll
send you identical copies with a correct subject line right away.

	Arnd
