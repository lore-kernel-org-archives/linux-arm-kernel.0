From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 23 Oct 2012 13:39:05 +0200
Subject: [PATCH] ARM: dma-mapping: support debug_dma_mapping_error
In-Reply-To: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
References: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
Message-ID: <508681D9.7060305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 10/22/2012 2:44 PM, Ming Lei wrote:

> Without the patch, kind of below warning will be dumped if DMA-API
> debug is enabled:
>
> [   11.069763] ------------[ cut here ]------------
> [   11.074645] WARNING: at lib/dma-debug.c:948 check_unmap+0x770/0x860()
> [   11.081420] ehci-omap ehci-omap.0: DMA-API: device driver failed to
> check map error[device address=0x0000000
> 0adb78e80] [size=8 bytes] [mapped as single]
> [   11.095611] Modules linked in:
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Thanks for the patch, I've applied it to my kernel tree.

> ...

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
