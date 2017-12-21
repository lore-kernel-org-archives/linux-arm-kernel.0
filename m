From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Dec 2017 16:55:56 -0600
Subject: [PATCH net 1/2] dt-bindings: net: mediatek: add condition to
 property mediatek,pctl
In-Reply-To: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
References: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
Message-ID: <20171221225556.ecue4cnkhzuxk2rh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 05:47:05PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The property "mediatek,pctl" is only required for SoCs such as MT2701 and
> MT7623, so adding a few words for stating the condition.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/net/mediatek-net.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
