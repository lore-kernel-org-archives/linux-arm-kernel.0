From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 5 Jan 2015 12:08:23 +0100
Subject: [PATCH 09/28] iommu: drop owner assignment from platform_drivers
In-Reply-To: <1419196495-9626-10-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-10-git-send-email-wsa@the-dreams.de>
Message-ID: <20150105110823.GC19590@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 10:14:30PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> Generated with coccinelle. SmPL file is in the introductory msg. The big
> cleanup was pulled in this merge window. This series catches the bits fallen
> through. The patches shall go in via the subsystem trees.
> 
>  drivers/iommu/rockchip-iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to iommu/fixes, thanks Wolfram.
