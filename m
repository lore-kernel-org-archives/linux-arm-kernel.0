From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Apr 2011 09:13:09 +0900
Subject: [PATCH 1/2] mach-ux500: voltage domain regulators for DB8500
In-Reply-To: <1301907068-16733-1-git-send-email-linus.walleij@stericsson.com>
References: <1301907068-16733-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110405001308.GC5376@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 10:51:08AM +0200, Linus Walleij wrote:

>  arch/arm/mach-ux500/regulator-db8500.c |  562 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-ux500/regulator-db8500.h |   45 +++

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though I would prefer to see the regulator driver in drivers/regulator
(though splitting the underlying integration with cpuidle isn't a
problem) as this makes it easier to find all regulator drivers.
