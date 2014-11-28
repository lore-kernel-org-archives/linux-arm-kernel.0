From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 28 Nov 2014 09:34:24 +0100
Subject: [PATCH v5 1/2] Documentation: devicetree: Add ECC information
 to synopsys ddr controller
In-Reply-To: <1417101454-26361-1-git-send-email-punnaia@xilinx.com>
References: <1417101454-26361-1-git-send-email-punnaia@xilinx.com>
Message-ID: <5d58678ae1b84f40b6c8247a17cf1ee5@BN1AFFO11FD052.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2014 04:17 PM, Punnaiah Choudary Kalluri wrote:
> Add ECC information to synopsys ddr memory controller.
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
>  .../bindings/memory-controllers/synopsys.txt       |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> index f9c6454..a43d26d 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> @@ -1,5 +1,9 @@
>  Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
>  
> +This controller has an optional ECC support in half-bus width (16-bit)
> +configuration. The ECC controller corrects one bit error and detects
> +two bit errors.
> +
>  Required properties:
>   - compatible: Should be 'xlnx,zynq-ddrc-a05'
>   - reg: Base address and size of the controllers memory area
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
