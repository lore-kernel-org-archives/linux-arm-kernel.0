From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:23:42 +0100
Subject: [PATCH 3/4] serial: 8250-mtk: add uart DMA support
In-Reply-To: <1487243251-964-4-git-send-email-long.cheng@mediatek.com>
References: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
 <1487243251-964-4-git-send-email-long.cheng@mediatek.com>
Message-ID: <2041319.BERnyvUuuK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 16, 2017 7:07:30 PM CET Long Cheng wrote:
> Modify uart register to support DMA function.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c |  194 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 1 deletion(-)
> 

This code looks a lot like the one in 8250_omap.c and 8250_dma.c.
Could it be made more generic so we can share more of the implementation?

	Arnd
