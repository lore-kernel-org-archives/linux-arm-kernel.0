From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Jul 2016 20:17:45 -0500
Subject: [PATCH V3 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <20160719091723.30919-1-josephl@nvidia.com>
References: <20160719091723.30919-1-josephl@nvidia.com>
Message-ID: <20160720011745.GA7578@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 05:17:22PM +0800, Joseph Lo wrote:
> Add DT binding for the Hardware Synchronization Primitives (HSP). The
> HSP is designed for the processors to share resources and communicate
> together. It provides a set of hardware synchronization primitives for
> interprocessor communication. So the interprocessor communication (IPC)
> protocols can use hardware synchronization primitive, when operating
> between two processors not in an SMP relationship.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> Sorry. Please allow me just update the binding patches of this series.
> Want to make sure the binding is acceptable first.
> Thanks.
> 
> Changes in V3:
> - use two cells for mboxes property
> Changes in V2:
> - revise the compatible string, interrupt-names, interrupts, and #mbox-cells
>   properties
> - remove "nvidia,hsp-function" property
> - fix the header file name
> - the binding supports the concept of multiple HSP sub-modules on one HSP HW
>   block now.
> ---
>  .../bindings/mailbox/nvidia,tegra186-hsp.txt       | 52 ++++++++++++++++++++++
>  include/dt-bindings/mailbox/tegra186-hsp.h         | 20 +++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>  create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h

Acked-by: Rob Herring <robh@kernel.org>
