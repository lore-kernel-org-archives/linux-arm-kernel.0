From: marex@denx.de (Marek Vasut)
Date: Mon, 28 Apr 2014 22:22:08 +0200
Subject: [PATCH v2 01/10] mtd: spi-nor: fix the wrong dummy value
In-Reply-To: <1398657227-20721-2-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-2-git-send-email-b32955@freescale.com>
Message-ID: <201404282222.08181.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 28, 2014 at 05:53:38 AM, Huang Shijie wrote:
> For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then 8.
> The dummy cycles is actually 8 for SPI fast/dual/quad read.
> 
> This patch makes preparations for the DDR quad read, it fixes the wrong
> dummy value for both the spi-nor.c and m25p80.c.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
> This ia actually v3.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
