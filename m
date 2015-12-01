From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Dec 2015 08:43:17 -0800
Subject: [PATCH v2 01/18] ARM: am57xx: cl-som-am57x: dts: add basic
 module support
In-Reply-To: <565DC9CC.1070000@compulab.co.il>
References: <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il>
 <1448893551-676-1-git-send-email-lifshitz@compulab.co.il>
 <20151130215415.GE23396@atomide.com>
 <565DC9CC.1070000@compulab.co.il>
Message-ID: <20151201164317.GS23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [151201 08:26]:
> 
> It might looks the same set of regulators for multiple boards,
> but it is not. Each board may apply its own regulators usage scheme, and
> this is our case (as compared to am57xx-beagle-x15.dts).
> 
> For the best of my knowledge, it used to be in a common *.dtsi file (at
> least in early OMAP5 DT support in TI kernel tree), but then I found that
> PMIC registration had been moved to the boards DT files.

Have you actually looked at how much of the implementation is same across
the omap5 boards? My guess is that a whole lot is same.. See for example
omap5-board-common.dtsi.

Regards,

Tony
