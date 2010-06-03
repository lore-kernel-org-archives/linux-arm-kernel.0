From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Jun 2010 10:28:52 +0200
Subject: [PATCH v5] i.MX27: add suspend to RAM support
In-Reply-To: <1275422264-4040-1-git-send-email-eric@eukrea.com>
References: <20100527214642.GG25921@n2100.arm.linux.org.uk>
	<1275422264-4040-1-git-send-email-eric@eukrea.com>
Message-ID: <20100603082852.GV26820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 09:57:44PM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v5:
> 	remove const struct
> v4:
> 	fixed include + const struct
> v3:
> 	return -EINVAL instead of -1
> 
>  arch/arm/mach-mx2/Makefile   |    2 +-
>  arch/arm/mach-mx2/pm-imx27.c |   46 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mx2/pm-imx27.c

Ok, applied

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
