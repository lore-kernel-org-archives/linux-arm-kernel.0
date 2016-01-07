From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 07 Jan 2016 17:24:54 +0100
Subject: [PATCH v7 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <1451890598.11799.3.camel@mhfsdcap03>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
 <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
 <1451890598.11799.3.camel@mhfsdcap03>
Message-ID: <1452183894.4776.29.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, den 04.01.2016, 14:56 +0800 schrieb Yong Wu:
> On Fri, 2015-12-18 at 16:09 +0800, Yong Wu wrote:
> > This patch add SMI(Smart Multimedia Interface) driver. This driver
> > is responsible to enable/disable iommu and control the power domain
> > and clocks of each local arbiter.
> 
> Hi Matthias,
>     What's your opinion about the SMI in this version?
>     Sorry to disturb you again since SMI need your review before Joerg
> accept it.

How is this going to be merged, eventually? If it could be put on a
separate branch, that would allow me to also include it in the DRM pull
request that will build-depend on the SMI driver.

> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
