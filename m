From: pza@pengutronix.de (Philipp Zabel)
Date: Sun, 31 Jan 2016 16:40:12 +0100
Subject: [PATCH v8 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <56ADE959.2050309@gmail.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com>
Message-ID: <20160131154012.GA3628@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 12:00:41PM +0100, Matthias Brugger wrote:
> 
> 
> On 26/01/16 05:12, Yong Wu wrote:
> >This patch add SMI(Smart Multimedia Interface) driver. This driver
> >is responsible to enable/disable iommu and control the power domain
> >and clocks of each local arbiter.
> >
> >Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> >---
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Joerg would you mind to take this through your branch?

Could you put it on a separate branch that I may also merge into the DRM
driver pull request?

regards
Philipp
