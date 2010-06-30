From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Jun 2010 09:37:06 +0200
Subject: [PATCH 21/61] ARM: mx3: mx31lilly: fix build error for
	!CONFIG_USB_ULPI
In-Reply-To: <1277387397-3467-22-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1277387397-3467-22-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100630073706.GE11746@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 03:49:17PM +0200, Uwe Kleine-K?nig wrote:
> arch/arm/mach-mx3/built-in.o: In function `mx31lilly_board_init':
> mach-kzm_arm11_01.c:(.init.text+0x674): undefined reference to `otg_ulpi_create'
> mach-kzm_arm11_01.c:(.init.text+0x68c): undefined reference to `otg_ulpi_create'
> mach-kzm_arm11_01.c:(.init.text+0x744): undefined reference to `mxc_ulpi_access_ops'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
I dropped this from my series as it's only cherry-picked from Sascha's
tree for my build tests.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
