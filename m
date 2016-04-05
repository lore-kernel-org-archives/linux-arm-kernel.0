From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 Apr 2016 16:27:33 +0200
Subject: [PATCH] iommu/rockchip: Don't feed NULL res pointers to devres
In-Reply-To: <1458558024-6922-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458558024-6922-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20160405142732.GC11519@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 12:00:23PM +0100, Tomeu Vizoso wrote:
> If we do, devres prints a "invalid resource" string in the error
> loglevel.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

 
