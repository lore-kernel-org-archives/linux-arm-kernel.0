From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 14 Sep 2011 11:18:04 +0800
Subject: [PATCH] ARM: mach-mxs/mx28evk: Only register devices if their
	GPIO requests succeeded
In-Reply-To: <1315945519-15178-1-git-send-email-festevam@gmail.com>
References: <1315945519-15178-1-git-send-email-festevam@gmail.com>
Message-ID: <20110914031803.GC2368@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 05:25:19PM -0300, Fabio Estevam wrote:
> Currently framebuffer and MMC devices are registered even if their associated 
> GPIO pins fail to be requested.
> 
> Change the logic so that the registration of such devices only occurs if their 
> GPIO requests succeeded.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
So the question is whether the gpio request failure is a show-stopper
failure for framebuffer and mmc.

-- 
Regards,
Shawn
