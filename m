From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Wed, 24 Nov 2010 10:47:15 +0200
Subject: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC
	NL8048HL11-01B on OMAP34x-II MDP
In-Reply-To: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
References: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1290588435.13243.12.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2010-11-23 at 19:00 -0600, ext Omar Ramirez Luna wrote:
> From: Yanick Saugy <yanick.saugy@heig-vd.ch>
> 
> The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
> configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
> (CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)
> 
> Be aware of changing this PIN will probably disable the camera, because
> it was previously configured as a camera clock.
> 
> Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> 
> I'm not sure if this patch was forgotten, hence resending. Without
> it, a blanks screen is seen on zoom2 board.

Yes, I seem to have missed this.

But I'm a bit confused. You say that this will disable camera. Is there
a camera connected to the board, and it won't work after this? 

 Tomi
