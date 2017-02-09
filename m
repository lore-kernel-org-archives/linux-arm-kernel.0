From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 9 Feb 2017 16:19:08 +0800
Subject: [PATCH v4 3/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <d35fa104-1525-f30d-ddaa-94fc944557a6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?09? 11:12, Baoyou Xie wrote:
> The pclk is necessary for zx2967 I2S controller. the driver
> currently doesn't handle it. This is something we need to fix.
>
> In turn, the driver supports zx296718's I2S controller.
>
> By the way, this patch also change the clock name from tx to wclk
> to make it clear.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---

Reviewed-by: Jun Nie <jun.nie@linaro.org>
