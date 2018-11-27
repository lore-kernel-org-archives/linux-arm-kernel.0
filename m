From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 27 Nov 2018 22:26:12 +0100
Subject: [PATCH 2/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
In-Reply-To: <1543311334-8807-3-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181127212612.GA7569@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 27/11/2018 09:41:29+0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and secure RTC etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to do RTC operation, this patch adds binding doc for i.MX
> system controller RTC driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> 

This patch should come first to silence checkpatch.

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> new file mode 100644
> index 0000000..d6e2353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
> @@ -0,0 +1,10 @@
> +* NXP i.MX System Controller Real Time Clock
> +
> +Required properties:
> +- compatible: should be "nxp,imx8qxp-sc-rtc";
> +
> +Example:
> +
> +rtc: rtc {
> +	compatible = "nxp,imx8qxp-sc-rtc";
> +};
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
