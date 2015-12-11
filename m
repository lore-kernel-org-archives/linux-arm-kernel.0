From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 11 Dec 2015 15:22:30 +0800
Subject: [PATCH v6 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-4-git-send-email-yong.wu@mediatek.com>
Message-ID: <1449818550.14149.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-08 at 17:49 +0800, Yong Wu wrote:
> This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the power domain
> and clocks of each local arbiter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---

Hi Matthias,
   Because drivers/memory/ don't have the maintainer, and our IOMMU,
V4L2 and DRM rely on the SMI. From Joerg and Thierry[1], we need your
help. Could you have a loot at our SMI while free?
Look forward to any comment from you.
Thanks.

[1]http://lists.linuxfoundation.org/pipermail/iommu/2015-November/014981.html
