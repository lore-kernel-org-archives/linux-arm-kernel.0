From: robh@kernel.org (Rob Herring)
Date: Fri, 31 Mar 2017 13:58:52 -0500
Subject: [PATCH v5 14/24] dt-bindings: mfd: syscon: Add documentation for
 #syscon-cells property
In-Reply-To: <20170327094520.3129-15-kishon@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
 <20170327094520.3129-15-kishon@ti.com>
Message-ID: <20170331185852.mxa4gvjxbuxl65dq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 03:15:10PM +0530, Kishon Vijay Abraham I wrote:
> Add documentation for the optional #syscon-cells property to determine
> the number of cells that should be given in the phandle while
> referencing the syscon-node.
> 
> Suggested-by: Rob Herring <robh@kernel.org>

I did? When?

I'm not remembering why we need this. Generally, phandles to a syscon 
are for a single defined purpose. When do we need a list of them?

Rob

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> index 408f768686f1..446b47e8fb71 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -16,6 +16,8 @@ Required properties:
>  Optional property:
>  - reg-io-width: the size (in bytes) of the IO accesses that should be
>    performed on the device.
> +- #syscon-cells: determine the number of cells that should be given in the
> +  phandle while referencing this syscon-node.
>  
>  Examples:
>  gpr: iomuxc-gpr at 020e0000 {
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
