From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 10 Apr 2018 11:21:03 +0200
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: Add DMA support for direct
 mode reads
In-Reply-To: <20180410081910.858-1-vigneshr@ti.com>
References: <20180410081910.858-1-vigneshr@ti.com>
Message-ID: <70777773-8ade-bd42-e75a-6d5d9c3e50a2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2018 10:19 AM, Vignesh R wrote:
> Add support to use DMA over memory mapped reads in direct mode. This
> helps in reducing CPU usage from ~100% to ~10% when reading data from
> flash. For non-DMA'able/vmalloc'd buffers, driver just falls back to CPU
> based memcpy.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
