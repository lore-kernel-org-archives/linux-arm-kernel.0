From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 15 Nov 2017 12:06:42 +0800
Subject: [PATCH 09/10] dmaengine: k3dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-10-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-10-peter.ujfalusi@ti.com>
Message-ID: <b436c309-601e-2fbc-b5ad-6a7ffa27c793@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017?11?14? 22:32, Peter Ujfalusi wrote:
> To avoid race with vchan_complete, use the race free way to terminate
> running transfer.
>
> Implement the device_synchronize callback to make sure that the terminated
> descriptor is freed.
>
> CC: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks Peter.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
