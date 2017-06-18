From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Jun 2017 09:05:01 -0500
Subject: [PATCH v6 1/3] PCI: Add DT binding for tango PCIe controller
In-Reply-To: <3790db8d-6a4c-5c74-9ca2-431715a712a7@sigmadesigns.com>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
 <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
 <3790db8d-6a4c-5c74-9ca2-431715a712a7@sigmadesigns.com>
Message-ID: <20170618140501.mu3zrr5dw4fstshd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 03:51:32PM +0200, Marc Gonzalez wrote:
> Binding for the Sigma Designs SMP8759 SoC.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes from v5 to v6
> o Delete links to elinux.org
> o Use explicit hex numbers instead of symbolic constants for sizes (in the example)
> o Add bus-range to "Required properties"
> ---
>  .../devicetree/bindings/pci/tango-pcie.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
