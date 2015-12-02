From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 14:14:12 +0800
Subject: [PATCH V1] ARM: dts: imx6: Change the clock name for spba clock
In-Reply-To: <8cd5b975aa4792f1dd9ac2f8909689f8d2018160.1448505436.git.shengjiu.wang@freescale.com>
References: <8cd5b975aa4792f1dd9ac2f8909689f8d2018160.1448505436.git.shengjiu.wang@freescale.com>
Message-ID: <20151202061412.GI692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 10:39:30AM +0800, Shengjiu Wang wrote:
> Audio IP need the spba clock, but original clock name "dma" is not
> accurate, so change it to name "spba". The audio driver has been
> using the new name "spba", the binding document has been updated.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Applied, thanks.
