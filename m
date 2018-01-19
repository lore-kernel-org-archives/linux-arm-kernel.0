From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 13:20:26 -0600
Subject: [PATCH v4 2/8] dt-bindings: pci: Add DT docs for Brcmstb PCIe
 device
In-Reply-To: <1516058925-46522-3-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-3-git-send-email-jim2101024@gmail.com>
Message-ID: <20180119192026.b3bhiercl45u2mga@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 06:28:39PM -0500, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

I acked v3. Please add acks when posting new versions.
