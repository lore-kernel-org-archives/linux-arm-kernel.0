From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 1 Aug 2010 14:35:41 +0400
Subject: [PATCH 1/2] ARM: make a common low level IRQ helper macros for
	GIC based platforms
In-Reply-To: <1280408164.14531.13.camel@bnru03>
References: <1280408164.14531.13.camel@bnru03>
Message-ID: <20100801103541.GA27950@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 06:26:04PM +0530, srinidhi wrote:
> The IRQ helper macros for GIC based platforms are similar.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/include/asm/entry-macro-gic.S            |   74 ++++++++++++++++++++
>  arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |   73 +-------------------
>  arch/arm/mach-omap2/include/mach/entry-macro.S    |   67 +-----------------
>  arch/arm/mach-realview/include/mach/entry-macro.S |   72 +-------------------
>  arch/arm/mach-ux500/include/mach/entry-macro.S    |   77 +--------------------
>  arch/arm/mach-vexpress/include/mach/entry-macro.S |   68 +------------------
>  6 files changed, 81 insertions(+), 350 deletions(-)
>  create mode 100644 arch/arm/include/asm/entry-macro-gic.S

This works on CNS3xxx.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
