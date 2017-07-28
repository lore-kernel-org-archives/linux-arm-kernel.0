From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Fri, 28 Jul 2017 08:55:34 +0800
Subject: [PATCH 0/3] Add larbid init routine for mediatek's gen1 smi
 larb driver
In-Reply-To: <20170727125812.GD21502@8bytes.org>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
 <20170727125812.GD21502@8bytes.org>
Message-ID: <1501203334.29316.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-07-27 at 14:58 +0200, Joerg Roedel wrote:
> On Thu, Jul 27, 2017 at 10:01:09AM +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > Mediatek's gen1 smi need the hardware larbid to identify the offset for
> > the register which controls whether enable iommu for this larb.
> > In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
> > the larbid was used without properly initialized. This patchset fixed
> > that.
> > 
> > Honghui Zhang (3):
> >   memory: mtk-smi: add larbid init routine
> >   dt-bindings: mediatek: add descriptions for larbid
> >   arm: dts: mediatek: add larbid property for larb
> 
> What are these patches based on? They don't apply to v4.13-rc2.
> 
> 

Hi, Joerg,
	this patchset was base on the patch v2 version
memory: mtk-smi: Use of_device_get_match_data helper[1],
and it's base on 4.13-rc1

[1] https://patchwork.kernel.org/patch/9864719

thanks
> 
> 	Joerg
> 
