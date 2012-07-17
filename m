From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 17 Jul 2012 16:27:13 +0400
Subject: [PATCH v2 02/11] arm/dts: omap: Add omap-usb2 dt data
In-Reply-To: <1342512611-20529-3-git-send-email-kishon@ti.com>
References: <1342512611-20529-1-git-send-email-kishon@ti.com>
 <1342512611-20529-3-git-send-email-kishon@ti.com>
Message-ID: <50055A21.5010206@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-07-2012 12:10, Kishon Vijay Abraham I wrote:

> Add omap-usb2 data node in omap4 device tree file.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index bda5df3..4d2dcc1 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -279,6 +279,11 @@
>   			#size-cells = <1>;
>   			ranges;
>   			ti,hwmods = "ocp2scp_usb_phy";
> +			usb2phy at 0x4a0ad080 {

    There should be no "0x" prefix here.

WBR, Sergei
