From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Aug 2012 09:34:11 +0000
Subject: [PATCH v3 2/4] dmaengine: mmp_tdma: add dt support
In-Reply-To: <1344917519-9505-3-git-send-email-zhangfei.gao@marvell.com>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-3-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201208140934.11774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  Documentation/devicetree/bindings/dma/mmp-dma.txt |   30 ++++++++++++
>  drivers/dma/mmp_tdma.c                            |   51 +++++++++++++--------
>  2 files changed, 61 insertions(+), 20 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

but please add a changelog text for this patch and every other one you do.
