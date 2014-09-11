From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 11 Sep 2014 16:02:23 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410327012-31185-1-git-send-email-b38343@freescale.com>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
Message-ID: <20140911080222.GG18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 01:30:12PM +0800, Robin Gong wrote:
> There is one weird data in rxfifo after one full rx/tx transfer
> done sometimes. It looks a design issue and hard to workaround
> totally, so disable dma functhion here. And will re-enable it
> once the root cause found.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>

Applied, thanks.
