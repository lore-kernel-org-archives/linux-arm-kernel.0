From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 16:14:47 +0200
Subject: [PATCH] iommu: rockchip: Drop verbose prints in the interrupt
 handler
In-Reply-To: <20180830222832.16766-1-ezequiel@collabora.com>
References: <20180830222832.16766-1-ezequiel@collabora.com>
Message-ID: <3492511.ggRQRNLldU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 31. August 2018, 00:28:32 CEST schrieb Ezequiel Garcia:
> Printing verbosely via WARN macros and friends in interrupt handlers
> is strongly discouraged. Drop them and use proper ratelimited
> prints.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
