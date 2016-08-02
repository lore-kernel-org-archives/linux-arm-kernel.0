From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Aug 2016 03:35:05 -0700
Subject: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
In-Reply-To: <1469362260-20066-1-git-send-email-johan@kernel.org>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
Message-ID: <20160802103505.GD28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <johan@kernel.org> [160724 05:11]:
> Networking is currently broken for Overo boards due to a regression in
> 4.7. I bisected it down to
> 
> 	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
> 	for WAITPINs")
...

> Note that simply fixing the Overo NAND issue would fix the Overo
> networking regression, but by restoring the 4.6 gpmc-probe behaviour
> similar regressions on other OMAP systems are also avoided.

Roger, got a better fix in mind?

Regards,

Tony
