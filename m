From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 Apr 2016 16:57:26 +0200
Subject: [PATCH] iommu/rockchip: Only log stall errors when attaching
In-Reply-To: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20160405145726.GD11519@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 04:04:33PM +0100, Tomeu Vizoso wrote:
> Move the logging of timeouts when stalling the MMU to
> rk_iommu_attach_device, as it's expected that sometimes the MMU won't
> get stalled when detaching a device, and it's not a real problem that
> would need to be communicated to the user.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Heiko, any opinion on this patch?
