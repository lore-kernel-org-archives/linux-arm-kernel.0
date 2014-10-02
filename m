From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Oct 2014 12:09:31 +0100
Subject: [PATCH] PCI: xilinx: Trivial fix in DT example
In-Reply-To: <4a72f98ee8564b6b040d6301e2719e37ddfea663.1412246470.git.michal.simek@xilinx.com>
References: <4a72f98ee8564b6b040d6301e2719e37ddfea663.1412246470.git.michal.simek@xilinx.com>
Message-ID: <20141002110931.GH5788@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 11:41:19AM +0100, Michal Simek wrote:
> Good to have it properly describe for c&p cases.

Yup.

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> Based on linux-next. File should be in pci tree.
> ---
>  Documentation/devicetree/bindings/pci/xilinx-pcie.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
> index 3e2c88d97ad4..02f979a48aeb 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
> @@ -58,5 +58,5 @@ Example:
>  			interrupt-controller;
>  			#address-cells = <0>;
>  			#interrupt-cells = <1>;
> -		}
> +		};
>  	};
> --
> 1.8.2.3
> 
