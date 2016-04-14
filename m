From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:40:46 -0500
Subject: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Marvell
 Armada 7K/8K PCIe controller
In-Reply-To: <1460648177-31473-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1460648177-31473-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160414174046.GA25285@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 05:36:16PM +0200, Thomas Petazzoni wrote:
> This commit adds the Device Tree binding documentation that allows to
> describe the PCIe controller found in Marvell Armada 7K/8K SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/pci-armada8k.txt       | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt

I already acked the last version, did something change?

Acked-by: Rob Herring <rob@kernel.org>
