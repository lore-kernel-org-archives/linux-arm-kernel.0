From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 14:37:48 +0200
Subject: [PATCH v3 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
In-Reply-To: <20180702114033.15654-2-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-2-mperttunen@nvidia.com>
Message-ID: <20180702123748.GA13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:26PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
>     
>     v3:
>     - Added Jon's A-b and Rob's R-b
> 
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/3a5c8a64/attachment.sig>
