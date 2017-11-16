From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Nov 2017 23:07:17 -0600
Subject: [PATCH v3 2/8] dt-bindings: pci: Add DT docs for Brcmstb PCIe
 device
In-Reply-To: <1510697532-32828-3-git-send-email-jim2101024@gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-3-git-send-email-jim2101024@gmail.com>
Message-ID: <20171116050717.35lklxvhfvtuly5i@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 05:12:06PM -0500, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
