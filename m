From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 31 Jan 2016 12:00:41 +0100
Subject: [PATCH v8 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
Message-ID: <56ADE959.2050309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/01/16 05:12, Yong Wu wrote:
> This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the power domain
> and clocks of each local arbiter.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Joerg would you mind to take this through your branch?

Thanks,
Matthias
