From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 28 Mar 2017 20:15:40 -0700
Subject: [PATCH v3 1/5] dt-bindings: Document STM32 IWDG bindings
In-Reply-To: <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
Message-ID: <425a174f-91ca-75eb-cf3b-af8a1d06c705@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 08:04 AM, Yannick Fertre wrote:
> From: Yannick Fertre <yfertre.stm32@gmail.com>
>
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
>
> Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558

Please drop.

> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> new file mode 100644
> index 0000000..036b040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -0,0 +1,15 @@
> +STM32 Independent WatchDoG (IWDG)
> +---------------------------------
> +
> +Required properties:
> +- compatible: "st,stm32-iwdg"
> +- reg: physical base address and length of the registers set for the device
> +- clocks: must contain a single entry describing the clock input
> +
> +Example:
> +
> +iwdg at 40003000 {
> +	compatible = "st,stm32-iwdg";
> +	reg = <0x40003000 0x400>;
> +	clocks = <&clk_lsi>;
> +};
>
