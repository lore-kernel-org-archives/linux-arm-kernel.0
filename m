From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 14:38:36 -0500
Subject: [PATCH v3 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
In-Reply-To: <1535616829-167936-2-git-send-email-hanjie.lin@amlogic.com>
References: <1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com>
 <1535616829-167936-2-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <20180910193836.GA21297@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 16:13:48 +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
> 
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
