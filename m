From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 17:22:51 -0500
Subject: [PATCH] PCI: Xilinx NWL PCIe: Updating device tree documentation
 with prefetchable memory space
In-Reply-To: <1470751209-31203-1-git-send-email-bharatku@xilinx.com>
References: <1470751209-31203-1-git-send-email-bharatku@xilinx.com>
Message-ID: <20160810222251.GA31705@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 07:30:09PM +0530, Bharat Kumar Gogada wrote:
> Updating device tree documentation with prefetchable memory
> sapce.
> Configuration space shifted to 64-bit address space.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
