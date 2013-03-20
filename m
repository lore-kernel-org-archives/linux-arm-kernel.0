From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:28:20 +0000
Subject: [PATCH 0/8] SIRF multiplatform support
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <201303201228.21179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013, Arnd Bergmann wrote:
> 
> Here goes another one. Since the SIRF platforms are relatively new and
> clean, they are easy to convert to multiplatform, so I did that and
> fixed up a few other things in the process as well.
> 
> Barry, could you test these and report back if everything still works
> for you?
> 
> Thomas, John, Linus: Are you ok with the irqchip/clocksource/pinctrl
> changes?
> 

I should have mentioned that my patches also depend on the clocksource
changes from Rob Herring. Barry, when you test this, you can get the
branch from the "sirf/multiplatform" branch of the arm-soc tree.

	Arnd
