From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 13 Feb 2018 14:41:28 +0100
Subject: [PATCH v4] iommu/mediatek: Move attach_device after iommu-group
 is ready for M4Uv1
In-Reply-To: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
References: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20180213134128.nki33e2yljv7scis@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 03:11:28PM +0800, Yong Wu wrote:
> ---
>  drivers/iommu/mtk_iommu_v1.c | 54 +++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)

Applied, thanks.
