From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Sep 2012 07:55:17 +0000
Subject: [PATCH 04/24] ARM: ep93xx: use __iomem pointers for MMIO
In-Reply-To: <5053AC44.1030909@gmail.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-5-git-send-email-arnd@arndb.de>
 <5053AC44.1030909@gmail.com>
Message-ID: <201209150755.18188.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Ryan Mallon wrote:
> On 15/09/12 07:34, Arnd Bergmann wrote:
> 
> > ARM is moving to stricter checks on readl/write functions,
> > so we need to use the correct types everywhere.
> > 
> > Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Ryan Mallon <rmallon@gmail.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> Hi Arnd,
> 
> Do you want me to queue both this and my patch to move the 
> ts72xx.h header into arch/arm/mach-ep93xx on to my ep93xx-fixes
> branch? That way you won't have to deal with any conflicts at
> your end.
> 

Yes, that would be great, thanks!

	Arnd
