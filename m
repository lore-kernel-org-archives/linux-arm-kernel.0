From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 20:58:47 +0900
Subject: [GIT PULL] regarding PL330 driver for rmk or arm-soc,
 and	slave-dma
In-Reply-To: <20120210110800.GU889@n2100.arm.linux.org.uk>
References: <010601cce7e1$5850a600$08f1f200$%kim@samsung.com>
 <20120210110800.GU889@n2100.arm.linux.org.uk>
Message-ID: <012b01cce7eb$58baf500$0a30df00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Feb 10, 2012 at 07:47:12PM +0900, Kukjin Kim wrote:
> >  arch/arm/common/Kconfig                        |    3 -
> >  arch/arm/common/Makefile                       |    1 -
> >  arch/arm/common/pl330.c                        | 1959
-----------------------
> -
> >  arch/arm/include/asm/hardware/pl330.h          |  338 +++--
> 
> I think I've already said this, but I'm going to say it again.
> 
> Code in arch/arm/include/asm/hardware/pl330.h which is only used by
> drivers/dma/pl330.c, needs to move to drivers/dma/pl330.h or into
> drivers/dma/pl330.c itself.
> 
> Anything else left over which needs to be used by others can go into
> include/linux/amba/pl330.h.
> 
OK, I agree. I will address comment from you, then submit it and re-send
'pull request' in the beginning of next week.

If any other problem, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
