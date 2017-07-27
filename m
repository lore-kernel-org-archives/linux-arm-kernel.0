From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 27 Jul 2017 14:58:12 +0200
Subject: [PATCH 0/3] Add larbid init routine for mediatek's gen1 smi larb
 driver
In-Reply-To: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20170727125812.GD21502@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 10:01:09AM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Mediatek's gen1 smi need the hardware larbid to identify the offset for
> the register which controls whether enable iommu for this larb.
> In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
> the larbid was used without properly initialized. This patchset fixed
> that.
> 
> Honghui Zhang (3):
>   memory: mtk-smi: add larbid init routine
>   dt-bindings: mediatek: add descriptions for larbid
>   arm: dts: mediatek: add larbid property for larb

What are these patches based on? They don't apply to v4.13-rc2.



	Joerg
