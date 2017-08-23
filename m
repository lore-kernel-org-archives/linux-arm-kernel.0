From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Aug 2017 19:36:29 -0500
Subject: [PATCH v4 2/3] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
In-Reply-To: <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
 <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20170823003629.pwnuashutcqujdmb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:36:53AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT7622 limits message numbers to 255, and does not
> support 4GB DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
