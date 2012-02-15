From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 11:56:28 -0800
Subject: [PATCH v5 1/2] mxs-dma : move the mxs dma.h to a more common place
In-Reply-To: <1329110756-14434-2-git-send-email-b32955@freescale.com>
References: <1329110756-14434-1-git-send-email-b32955@freescale.com>
 <1329110756-14434-2-git-send-email-b32955@freescale.com>
Message-ID: <20120215195627.GC2399@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 01:25:55PM +0800, Huang Shijie wrote:
> Move the header to a more common place.
> The mxs dma engine is not only used in mx23/mx28, but also used
> in mx50/mx6q.  It will also be used in the future chips.
> 
> Rename it to mxs-dma.h, and create a new folder include/linux/fsl/ to
> store the Freescale's header files.
> 
> change mxs-dma driver, mxs-mmc driver, gpmi-nand driver, mxs-saif driver
> to the new header file.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
