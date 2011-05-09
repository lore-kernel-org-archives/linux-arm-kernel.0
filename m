From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 08:19:35 -0700
Subject: [PATCH v2] omap: fix build when MTD_NAND_OMAP2 and
	TOUCHSCREEN_ADS7846 are disabled
In-Reply-To: <1304711893-24299-1-git-send-email-mike@compulab.co.il>
References: <20110506072523.GA25670@atomide.com>
	<1304711893-24299-1-git-send-email-mike@compulab.co.il>
Message-ID: <20110509151935.GC11410@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Rapoport <mike@compulab.co.il> [110506 12:54]:
> Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
> NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
> (omap: consolidate touch screen initialization among different boards)
> break compilation when CONFIG_MTD_NAND_OMAP2 and
> CONFIG_TOUCHSCREEN_ADS7846 are not selected.
> Removing ifdefs and stubs from common-board-devices.h fixes the problem.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Oleg Drokin <green@linuxhacker.ru>
> ---
> Hope this one is better.

Thanks, I'll fold this into your original patch.

Tony
