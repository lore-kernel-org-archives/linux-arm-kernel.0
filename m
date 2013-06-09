From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 9 Jun 2013 07:14:18 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
 GFX hwmod
In-Reply-To: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
References: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.02.1306090714080.20050@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 5 May 2013, Vaibhav Hiremath wrote:

> GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> so update the GFX hwmod data with .rstst_off and .st_shift
> information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued.

- Paul
