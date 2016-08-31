From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 21:48:24 +0300
Subject: [PATCH v3 0/8] drm/tilcdc: Address LCDC rev 2 color errata +
 other fixes
In-Reply-To: <20160831180418.rte4sf5s4llyuuvn@atomide.com>
References: <cover.1472634657.git.jsarha@ti.com>
 <20160831180418.rte4sf5s4llyuuvn@atomide.com>
Message-ID: <c049825a-0802-0637-3b1e-5290032e6d10@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/16 21:04, Tony Lindgren wrote:
> * Jyri Sarha <jsarha@ti.com> [160831 06:19]:
>>   ARM: dts: am335x-boneblack: Add blue-and-red-wiring -property to LCDC
>>     node
>>   ARM: dts: am335x-evm: Add blue-and-red-wiring -property to lcdc node
>>   ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
>>   ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node
> 
> If some of these dts changes are OK for me to apply separately already,
> please let me know.
> 
> Otherwise I'll tag this thread as read and assume you'll send the dts
> changes separately when ready :)
> 

According to my plan the drm side changes should go into 4.9.

The commit messages and the comments may look confusing without the
implementation, but otherwise there should be no harm in applying these
already. The new properties in dts simply wont have any effect. On the
other hand, not having the dts changes won't have any dramatic effect
either. The supported colour formats will just remain in the same
incorrect state as they have always been until the dts changes are
there. So what ever is more convenient for you.

Thanks,
Jyri
