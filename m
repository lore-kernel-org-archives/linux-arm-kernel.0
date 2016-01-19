From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 19 Jan 2016 08:50:57 -0800
Subject: [LINUX PATCH 2/5] Documentation: mmc: Updated the binding doc
 for Arasan SDHCI.
In-Reply-To: <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
Message-ID: <20160119165057.GN6491@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-19 at 07:47PM +0530, P L Sai Krishna wrote:
> This patch adds broken-tuning property to the binding
> doc for Arasan SDHCI.
> 
> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index da541c3..2088d9f 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -17,6 +17,10 @@ Required Properties:
>    - interrupt-parent: Phandle for the interrupt controller that services
>  		      interrupts for this device.
>  
> +Optional Properties:
> +  - broken-tuning: Indicates tuning broken in Silicon 1.0 of
> +			  Zynq Ultrascale+ MPSoC.

Describe the purpose/values of the property without reference to the
SoC. Other broken implementations would want to use this property too.

	S?ren
