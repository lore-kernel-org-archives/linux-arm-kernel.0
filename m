From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:04:43 -0600
Subject: [PATCH v1 2/2] dt-bindings: pinctrl: update bindings for MT7629
 SoC
In-Reply-To: <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
References: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
 <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
Message-ID: <20181117160443.GA1462@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2018 09:45:06 +0800, Ryder Lee wrote:
> This updates bindings for MT7629 pinctrl driver.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v1:
> -add new function for wifi.
> -add more descriptions.
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
