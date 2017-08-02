From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 2 Aug 2017 10:24:07 +0800
Subject: [PATCH v1 0/4] media: rc: add support for IR receiver on MT7622
 SoC
In-Reply-To: <20170704101008.pgnjacbsk3twadzo@gangnam.samsung>
References: <CGME20170630060312epcas4p351a77795e8469640d5177039f6b1955d@epcas4p3.samsung.com>
 <cover.1498794408.git.sean.wang@mediatek.com>
 <20170704101008.pgnjacbsk3twadzo@gangnam.samsung>
Message-ID: <1501640647.17690.25.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Mauro and Sean

Just a gentle ping on the whole patchset porting MediaTek CIR to another
platform.

	Sean


On Tue, 2017-07-04 at 19:10 +0900, Andi Shyti wrote:
> Hi Sean,
> 
> > This patchset introduces Consumer IR (CIR) support for MT7622 SoC
> > implements raw mode for more compatibility with different protocols
> > as previously SoC did. Before adding support to MT7622 SoC, extra
> > code refactor is done since there're major differences in register and
> > field definition from the previous SoC.
> > 
> > Sean Wang (4):
> >   dt-bindings: media: mtk-cir: Add support for MT7622 SoC
> >   media: rc: mtk-cir: add platform data to adapt into various hardware
> >   media: rc: mtk-cir: add support for MediaTek MT7622 SoC
> >   MAINTAINERS: add entry for MediaTek CIR driver
> 
> for the whole patchset:
> 
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> 
> Andi
