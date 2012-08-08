From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 15:50:19 +0100
Subject: [PATCH 09/11] regulator/twl: remove fixed resource handling
In-Reply-To: <1344437248-20560-10-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-10-git-send-email-arnd@arndb.de>
Message-ID: <20120808145018.GD24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:47:26PM +0200, Arnd Bergmann wrote:
> The recent patch 0e8e5c34cf "regulator: twl: Remove references to
> 32kHz clock from DT bindings" removed the only use of the fake
> "CLK32KG" regulator but not the TWL6030_FIXED_RESOURCE and
> twl6030_fixed_resource definitions that are unused otherwise.

I've already got a fix for this in my tree.

Please do also make an effort to use subject lines that match the style
of the subsystem.
