From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2012 15:06:24 +0000
Subject: [PATCH 09/11] regulator/twl: remove fixed resource handling
In-Reply-To: <20120808145018.GD24328@opensource.wolfsonmicro.com>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-10-git-send-email-arnd@arndb.de>
 <20120808145018.GD24328@opensource.wolfsonmicro.com>
Message-ID: <201208081506.24773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 04:47:26PM +0200, Arnd Bergmann wrote:
> > The recent patch 0e8e5c34cf "regulator: twl: Remove references to
> > 32kHz clock from DT bindings" removed the only use of the fake
> > "CLK32KG" regulator but not the TWL6030_FIXED_RESOURCE and
> > twl6030_fixed_resource definitions that are unused otherwise.
> 
> I've already got a fix for this in my tree.

Ok, dropping it here.

	Arnd
