From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 10:30:19 +0200
Subject: [PATCH] iommu/rockchip: silence attaching and detaching of devices
In-Reply-To: <1638542.l3M1oAbtAT@phil>
References: <1638542.l3M1oAbtAT@phil>
Message-ID: <20150529083018.GC13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 09:57:29AM +0200, Heiko Stuebner wrote:
> Currently the driver emits a log line every time a device attaches or
> detaches - which happens at every unblank/blank of the drm for example.
> The message itself also has no real value to the average user and is
> merely useful when debugging a problem, so make it a dev_dbg instead.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
