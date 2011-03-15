From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Mar 2011 09:43:20 +0100
Subject: [PATCH] ARM: mx5: fix clk id for a few DEFINE_CLOCK
In-Reply-To: <1300114343-3736-1-git-send-email-shawn.guo@freescale.com>
References: <1300114343-3736-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110315084319.GK29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 10:52:23PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Wouldn't it make more sense to remove the id field completely? It is
unused. Additionally, I see fundamental changes in the i.MX clock
framework in the not-so-far future, so I wouldn't make cosmetic patches
now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
