From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Aug 2018 19:37:22 -0500
Subject: [PATCH v2 1/2] dt-bindings: phy: add DT bindings for Amlogic
 Meson PCIe Phy controller
In-Reply-To: <1535096006-152091-2-git-send-email-hanjie.lin@amlogic.com>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-2-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <20180829003722.GA25763@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Aug 2018 15:33:25 +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> of the PCI Express Gen 2 specification and is backward compatible
> with the 2.5-Gbps Gen 1.1 specification with only
> inferred idle detection supported on Amlogic SoCs.
> 
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> ---
>  .../bindings/phy/amlogic,meson-pcie-phy.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
