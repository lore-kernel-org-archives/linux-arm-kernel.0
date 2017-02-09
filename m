From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Feb 2017 11:22:40 +0800
Subject: [PATCH v4 3/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170209032238.GQ3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 11:12:58AM +0800, Baoyou Xie wrote:
> The pclk is necessary for zx2967 I2S controller. the driver
> currently doesn't handle it. This is something we need to fix.
> 
> In turn, the driver supports zx296718's I2S controller.
> 
> By the way, this patch also change the clock name from tx to wclk
> to make it clear.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Shawn Guo <shawnguo@kernel.org>
