From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2018 05:55:54 -0700
Subject: [PATCH 1/2] ARM: OMAP1: ams-delta: refactor late_init()
In-Reply-To: <20180527135548.7904-1-jmkrzyszt@gmail.com>
References: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Message-ID: <20180702125554.GW112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180527 06:58]:
> Before the board level GPIO handling is converted from GPIO numbers to
> GPIO descriptors, split late_init() into functional blocks and move
> them to separate functions.
> 
> While being at it, drop machine type check from late_init() - the
> function is now called from the board init_late callback so there is
> no need for yet another applicability check.

Applying both into omap-for-v4.19/omap1 thanks.

Tony
