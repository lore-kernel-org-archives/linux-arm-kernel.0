From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 21:02:20 -0500
Subject: [PATCH v2 3/4] dt-bindings: mt8173-mtu3: add generic compatible
 and rename file
In-Reply-To: <2e43d8152c222264eb6c9d8299a824378c35a5a6.1502854628.git.chunfeng.yun@mediatek.com>
References: <670f9ce1ecaec5859006b6f02b45cfc72c3cca2c.1502854628.git.chunfeng.yun@mediatek.com>
 <2e43d8152c222264eb6c9d8299a824378c35a5a6.1502854628.git.chunfeng.yun@mediatek.com>
Message-ID: <20170822020220.q4odg5g3t7mnud7e@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 02:08:12PM +0800, Chunfeng Yun wrote:
> The mt8173-mtu3.txt actually holds the bindings for all mediatek
> SoCs with usb3 DRD IP, so add a generic compatible and change the
> name to mediatek,mtu3.txt.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../usb/{mt8173-mtu3.txt => mediatek,mtu3.txt}     |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/usb/{mt8173-mtu3.txt => mediatek,mtu3.txt} (92%)

Acked-by: Rob Herring <robh@kernel.org>
