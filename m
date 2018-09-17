From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:45:01 -0400
Subject: [PATCH 1/2] dt-bindings: phy: add UniPhier PCIe PHY description
In-Reply-To: <1536140985-6058-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536140985-6058-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <5b9f3f5f.1c69fb81.7a5bc.feae@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  5 Sep 2018 18:49:44 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PHY interface built into PCIe controller implemented
> in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
