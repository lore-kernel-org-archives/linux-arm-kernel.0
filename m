From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 5 Nov 2014 00:27:29 -0800
Subject: [PATCH v2 01/10] mtd: spi-nor: fix the wrong dummy value
In-Reply-To: <1398657227-20721-2-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-2-git-send-email-b32955@freescale.com>
Message-ID: <20141105082729.GE22361@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:53:38AM +0800, Huang Shijie wrote:
> For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then 8.
> The dummy cycles is actually 8 for SPI fast/dual/quad read.
> 
> This patch makes preparations for the DDR quad read, it fixes the wrong dummy
> value for both the spi-nor.c and m25p80.c.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
> This ia actually v3.

Don't know why this got left behind. Applied to l2-mtd.git.

Brian
