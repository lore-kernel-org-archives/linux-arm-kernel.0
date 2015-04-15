From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Apr 2015 11:51:18 +0000
Subject: [PATCH] irqchip/gicv3-its: Decrease page size when needed
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20150415115118.GN18660@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minghuan Lian,

On Wed, Apr 15, 2015 at 05:49:22PM +0800, Minghuan Lian wrote:
> The default page size of ITS table has been changed to 64KB,
> but for some platforms the real size of allocate memory which
> calculated by DEVBITS of register GITS_TYPER may smaller than
> default size. In this case, psz must be decreased, otherwise,
> the wrong page number will cause kernel hang.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
>  1 file changed, 3 insertions(+)

Please run scripts/get_maintainer.pl on your patches before sending.  This
needs to be sent to myself and Thomas Gleixner for review.

The merge window just opened, so nothing new is being added to the tree
currently.  Go ahead and resend after a few days.

thx,

Jason.
