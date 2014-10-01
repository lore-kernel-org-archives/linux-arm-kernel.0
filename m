From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Oct 2014 12:21:50 +0100
Subject: [PATCH 1/6] Documentation: DT: Add bindings for Spreadtrum serial
In-Reply-To: <1411992293-7729-2-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-2-git-send-email-zhang.lyra@gmail.com>
Message-ID: <20141001112149.GA13759@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 01:04:48PM +0100, zhang.lyra at gmail.com wrote:
> From: "chunyan.zhang" <chunyan.zhang@spreadtrum.com>
> 
> Adds the device-tree documentation for Spreadtrum's serial.
> 
> Signed-off-by: chunyan.zhang <chunyan.zhang@spreadtrum.com>
> ---
>  .../devicetree/bindings/serial/of-serial.txt       |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
> index 7705477..a0bb1d1 100644
> --- a/Documentation/devicetree/bindings/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/of-serial.txt
> @@ -14,6 +14,7 @@ Required properties:
>  	- "altr,16550-FIFO32"
>  	- "altr,16550-FIFO64"
>  	- "altr,16550-FIFO128"
> +	- "sprd,serial"

Is there not a more specific name? I'd imagine you might build a
different uart in future.

I didn't spot "sprd" in vendor-prefixes.txt in mainline. Is there a
patch adding that?

Mark.

>  	- "serial" if the port type is unknown.
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> -- 
> 1.7.9.5
> 
> 
