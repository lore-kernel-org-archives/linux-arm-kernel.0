From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 18 Feb 2016 02:03:05 +0000
Subject: [PATCH] irqchip: bcm2836: Drop extra memory barrier in SMP boot.
In-Reply-To: <1454620468-31303-1-git-send-email-eric@anholt.net>
References: <1454620468-31303-1-git-send-email-eric@anholt.net>
Message-ID: <20160218020305.GR5183@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 01:14:28PM -0800, Eric Anholt wrote:
> The writel() immediately after this has a barrier, anyway.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/irqchip/irq-bcm2836.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to irqchip/core

thx,

Jason.
