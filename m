From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 13:29:30 +0200
Subject: [PATCH] iommu: rockchip: Drop verbose prints in the interrupt
 handler
In-Reply-To: <20180830222832.16766-1-ezequiel@collabora.com>
References: <20180830222832.16766-1-ezequiel@collabora.com>
Message-ID: <20180925112930.u5kftmo3vhmdxji4@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 07:28:32PM -0300, Ezequiel Garcia wrote:
> Printing verbosely via WARN macros and friends in interrupt handlers
> is strongly discouraged. Drop them and use proper ratelimited
> prints.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

This doesn't apply cleanly to v4.19-rc5, can you please base the patch
on that tag, add the Reviewed-by and re-send?

Thanks,

	Joerg
