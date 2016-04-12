From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 13:46:45 +0800
Subject: [PATCH v2 1/4] ARM: dts: imx6sx: Fix SAI DMA index
In-Reply-To: <1459554737-19684-1-git-send-email-festevam@gmail.com>
References: <1459554737-19684-1-git-send-email-festevam@gmail.com>
Message-ID: <20160412054645.GA23166@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 08:52:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to sdma_peripheral_type in include/linux/platform_data/dma-imx.h
> IMX_DMATYPE_SAI corresponds to index 24, so fix it accordingly.
> 
> Suggested-by: Zidan Wang <zidan.wang@nxp.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
