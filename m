From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 14:51:54 +0200
Subject: [PATCH v3 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
In-Reply-To: <20180702114033.15654-3-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-3-mperttunen@nvidia.com>
Message-ID: <20180702125154.GD13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:27PM +0300, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Added Rob's Reviewed-by.
>     
>     v3:
>     - Added Jon's Acked-by.
> 
>  .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/fc4b5fb3/attachment.sig>
