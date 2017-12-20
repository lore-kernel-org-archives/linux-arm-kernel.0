From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 12:43:47 -0600
Subject: [PATCH 1/3] dt-bindings: i2c: Add MediaTek MT2712 i2c binding
In-Reply-To: <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <20171220184347.o2f5ez3n4vmbrq7w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:51:01PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2712 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT2712 has timing adjust registers which can adjust
> the internal divider of i2c source clock, SCL duty cycle, SCL
> compare point, start(repeated start) and stop time, SDA change
> time.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
