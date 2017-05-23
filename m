From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 09:57:12 -0500
Subject: [PATCH 1/2] Document: DT: Add bindings for Mediatek MT2712 SoC
 Platform
In-Reply-To: <1495192186-22480-2-git-send-email-yt.shen@mediatek.com>
References: <1495192186-22480-1-git-send-email-yt.shen@mediatek.com>
 <1495192186-22480-2-git-send-email-yt.shen@mediatek.com>
Message-ID: <20170523145712.wos6fwow6srwgjgd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 07:09:45PM +0800, YT Shen wrote:
> This adds dt-binding documentation for Mediatek MT2712.
> Only include very basic items: cpu, gic and uart.

'dt-bindings: arm: ...' is the preferred subject prefix.

> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt                    | 4 ++++
>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      | 1 +
>  Documentation/devicetree/bindings/serial/mtk-uart.txt                 | 1 +
>  3 files changed, 6 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
