From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 4 Jan 2016 14:56:38 +0800
Subject: [PATCH v7 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
 <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
Message-ID: <1451890598.11799.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-18 at 16:09 +0800, Yong Wu wrote:
> This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the power domain
> and clocks of each local arbiter.

Hi Matthias,
    What's your opinion about the SMI in this version?
    Sorry to disturb you again since SMI need your review before Joerg
accept it.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/Kconfig     |   8 ++
>  drivers/memory/Makefile    |   1 +
>  drivers/memory/mtk-smi.c   | 268 +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/mediatek/smi.h |  58 ++++++++++
>  4 files changed, 335 insertions(+)
>  create mode 100644 drivers/memory/mtk-smi.c
>  create mode 100644 include/soc/mediatek/smi.h
> 
[...]
