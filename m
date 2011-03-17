From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Mar 2011 22:12:26 +0100
Subject: [PATCHv3 2/3] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA1B7F51@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1300305787-7970-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-2-git-send-email-Dinh.Nguyen@freescale.com>
	<20110317081832.GS29521@pengutronix.de>
	<56132A77AB93C141BF06E6B96CA6CFEA1B7F51@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20110317211226.GC31219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Thu, Mar 17, 2011 at 04:52:44PM +0000, Nguyen Dinh-R00091 wrote:
> Yes, I have and its build fine for mx3_defconfig. I did find a build issue with mx27_defconfig, but it's not related to this patch:
> 
> In file included from arch/arm/mm/init.c:27:
> /arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> arch/arm/include/asm/tlb.h:104: error: implicit declaration of function 'release_pages'
> arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> arch/arm/include/asm/tlb.h:168: error: implicit declaration of function 'page_cache_release'
> make[1]: *** [arch/arm/mm/init.o] Error 1
> make: *** [arch/arm/mm] Error 2
This is already fixed in Russell's tree, and I guess in Linus', too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
