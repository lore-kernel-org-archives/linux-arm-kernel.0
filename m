From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 12:35:50 +0100
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA
 controllers
In-Reply-To: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
References: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
Message-ID: <201411281235.50962.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014, H Hartley Sweeten wrote:
> The dma_mask and coherent_dma_mask need to be set or DMA memory allocations
> will fail with error messages like this:
> 
>   ep93xx-dma ep93xx-dma-m2p: coherent DMA mask is unset
> 
>   ep93xx-dma ep93xx-dma-m2m: coherent DMA mask is unset
> 
> Add the missing information to the ep93xx-dma-m2p and ep93xx-dma-m2m
> devices.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Reported-by: Jeremy Moles <cubicool@gmail.com>
> Tested-by: Alexander Sverdlin <subaparts@yandex.ru>
> Cc: Ryan Mallon <rmallon@gmail.com>

Applied to next/fixes-non-critical. I couldn't tell from your description
whether you want this on 3.18 or even backported to older releases,
which I guess would make sense.

If you want a backport, let me know.

Thanks,

	Arnd
