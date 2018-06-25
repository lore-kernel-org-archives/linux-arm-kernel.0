From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 13:07:39 -0600
Subject: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
In-Reply-To: <20180620122042.10950-2-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-2-mperttunen@nvidia.com>
Message-ID: <20180625190739.GA10143@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:20:35PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings. At the same time, add the compatibility string for
> tegra194-hsp, which is backwards compatible with tegra186.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
> 
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
