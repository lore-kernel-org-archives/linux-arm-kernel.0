From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 21 Mar 2018 13:18:24 +0800
Subject: [PATCH] iommu/mediatek: Fix protect memory setting
In-Reply-To: <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
References: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
 <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
Message-ID: <1521609504.24119.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Tue, 2018-03-20 at 13:57 -0500, Joerg Roedel wrote:
> On Sun, Mar 18, 2018 at 09:52:54AM +0800, Yong Wu wrote:
> > To avoid adding this complex macro or a new function, I put
> > it in the code and backup its value in the suspend registers.
> 
> Missing Signed-off-by.

Signed-off-by and Reported-by have been added above.

====
Reported-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
====

> 
> > ---
> >  drivers/iommu/mtk_iommu.c | 15 ++++++++++-----
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> 
> Joerg
