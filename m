From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 16:11:01 -0600
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek
 MT6765 Platform
In-Reply-To: <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
 <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
Message-ID: <20180703221101.GA6829@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 10:04:05AM +0800, Mars Cheng wrote:
> This adds dt-binding documentation for Mediatek MT6765. Only
> include very basic items, gic, uart timer and cpu.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
>  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
>  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +

These can all go thru different trees, so should be split.

>  3 files changed, 6 insertions(+)
