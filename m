From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 19:57:24 -0500
Subject: [PATCH] dt-bindings: nvmem: mediatek: add support for MediaTek
 MT7623 and MT7622 SoC
In-Reply-To: <fc06fbe496ac237b961b73d51bb823e4ac2f8578.1498808678.git.sean.wang@mediatek.com>
References: <fc06fbe496ac237b961b73d51bb823e4ac2f8578.1498808678.git.sean.wang@mediatek.com>
Message-ID: <20170710005724.s4t6ejp73aipgp6b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 03:49:00PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek MT7622 and
> MT7623 SoC. For the both SoCs supported all rely on the fallback
> binding of the generic case with "mediatek,efuse".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Rob
