From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 26 Nov 2014 22:56:48 +0100
Subject: [PATCH] arm: omap2: rx51-peripherals: fix build warning
In-Reply-To: <1417033655-32332-1-git-send-email-balbi@ti.com>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
Message-ID: <20141126215648.GA10126@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> si4713 platform data) updated board-rx51-peripherals.c
> so that si4713 could be easily used on DT boot, but
> it ended up introducing a build warning whenever
> si4713 isn't enabled.
> 
> This patches fixes that warning:
> 
> arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> 	?rx51_si4713_platform_data? defined but not used [-Wunused-variable]
>  static struct si4713_platform_data rx51_si4713_platform_data = {
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/154769c8/attachment-0001.sig>
