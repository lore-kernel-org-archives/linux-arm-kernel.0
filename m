From: mporter@ti.com (Matt Porter)
Date: Wed, 22 Feb 2012 12:15:11 -0500
Subject: [PATCH 0/2] omap: fix omap2plus defaults for am35xx parts
In-Reply-To: <1328818586-7104-1-git-send-email-mporter@ti.com>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
Message-ID: <20120222171511.GC20411@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 03:16:24PM -0500, Matt Porter wrote:
> This series enables all current am35xx boards and the on-chip Ethernet
> driver in omap2plus_defconfig. It will help users of these boards to
> have a working defconfig out of the box.
> 
> Matt Porter (2):
>   omap: enable davinci_emac in omap2plus_defconfig for am35xx
>   omap: build am3517crane board support by default
> 
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  arch/arm/mach-omap2/Kconfig          |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

Can these be queued for 3.4? It would be great to have
omap2plus_defconfig build craneboard support by default to help catch
any future regressions.

-Matt
