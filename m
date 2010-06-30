From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Jun 2010 15:28:11 +0300
Subject: [PATCH 14/16] omap: mux: Mux 2430 USB0HS_STP in board-2430.c
In-Reply-To: <20100630120723.2637.54397.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120723.2637.54397.stgit@baageli.muru.com>
Message-ID: <20100630122811.GR3843@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wed, Jun 30, 2010 at 02:07:23PM +0200, ext Tony Lindgren wrote:
>diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>index e06d65e..5f04d3f 100644
>--- a/drivers/usb/musb/omap2430.c
>+++ b/drivers/usb/musb/omap2430.c
>@@ -194,10 +194,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
> 	u32 l;
> 	struct omap_musb_board_data *data = board_data;
>
>-#if defined(CONFIG_ARCH_OMAP2430)
>-	omap_cfg_reg(AE5_2430_USB0HS_STP);
>-#endif

there's a patch from Anand taking care of this hunk, could you send only 
the hunk on board-2430sdp.c ?

this part on omap2430.c will go on next merge window.

-- 
balbi

DefectiveByDesign.org
