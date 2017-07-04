From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 04 Jul 2017 19:10:08 +0900
Subject: [PATCH v1 0/4] media: rc: add support for IR receiver on MT7622
 SoC
In-Reply-To: <cover.1498794408.git.sean.wang@mediatek.com>
References: <CGME20170630060312epcas4p351a77795e8469640d5177039f6b1955d@epcas4p3.samsung.com>
 <cover.1498794408.git.sean.wang@mediatek.com>
Message-ID: <20170704101008.pgnjacbsk3twadzo@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

> This patchset introduces Consumer IR (CIR) support for MT7622 SoC
> implements raw mode for more compatibility with different protocols
> as previously SoC did. Before adding support to MT7622 SoC, extra
> code refactor is done since there're major differences in register and
> field definition from the previous SoC.
> 
> Sean Wang (4):
>   dt-bindings: media: mtk-cir: Add support for MT7622 SoC
>   media: rc: mtk-cir: add platform data to adapt into various hardware
>   media: rc: mtk-cir: add support for MediaTek MT7622 SoC
>   MAINTAINERS: add entry for MediaTek CIR driver

for the whole patchset:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
