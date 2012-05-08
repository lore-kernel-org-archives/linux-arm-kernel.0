From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 May 2012 13:48:14 +0000
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FA913BA.30908@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
Message-ID: <201205081348.14269.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Lee Jones wrote:
> This piece of code plucks pre-defined initialisation values and from the 
> Device Tree and uses them to set-up regulator related registers on the 
> u8500. See 'struct ab8500_regulator_reg_init ab8500_regulator_reg_init' 
> in arch/arm/mach-ux500/board-mop500-regulators.c for reference.
> 
> I did run this past Arnd before writing the code and he agreed that this 
> would be suitable; however, if you know of a better way in which I can 
> do this, I'd be pleased to hear of it.

It was the best approach that I could think of for this, but I'm also
a total newbie on regulators.

	Arnd
