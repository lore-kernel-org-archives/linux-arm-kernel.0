From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2010 14:41:16 +0000
Subject: [PATCH 2/5] OMAP4: Add L2 Cache support
In-Reply-To: <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100204144116.GA27344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 07:55:44PM +0530, Santosh Shilimkar wrote:
> This patch adds L2 Cache support for OMAP4. External L2 cache
> is used in OMPA4

OMAP4.

> @@ -49,6 +50,58 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
>  static struct omap_board_config_kernel sdp4430_config[] __initdata = {
>  	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
>  };

Blank line here.
