From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 4 Aug 2017 12:06:33 +0200
Subject: [PATCH v3 0/4] Add larbid init routine for mediatek's gen1 smi
 larb driver
In-Reply-To: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20170804100632.GC17443@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 09:32:24AM +0800, honghui.zhang at mediatek.com wrote:
> Honghui Zhang (4):
>   memory: mtk-smi: Use of_device_get_match_data helper
>   memory: mtk-smi: add larbid handle routine
>   dt-bindings: mediatek: add descriptions for larbid
>   arm: dts: mediatek: add larbid property for larb
> 
>  .../memory-controllers/mediatek,smi-larb.txt       | 15 +++++++++++++
>  arch/arm/boot/dts/mt2701.dtsi                      |  3 +++
>  drivers/memory/mtk-smi.c                           | 26 ++++++++++++----------
>  3 files changed, 32 insertions(+), 12 deletions(-)

Applied, thanks.
