From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:11 -0600
Subject: [PATCH 1/2] dt-bindings: soc: add SCPSYS binding for MT7623 and
 MT7623A SoC
In-Reply-To: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
References: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
Message-ID: <20180205035334.rb6rsl2r6kk2kvtu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:12:47PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
> SoC. Where MT7623 SoC has the same definition about power domains with
> MT2701, so it's fine to using MT2701 ones as MT7623's fallback.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
