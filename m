From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Mar 2017 20:40:26 -0500
Subject: [PATCH v3 1/5] dt-bindings: Document STM32 IWDG bindings
In-Reply-To: <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
 <1490195083-25117-2-git-send-email-yannick.fertre@st.com>
Message-ID: <20170329014026.fxrv7hwoueh6tplm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 04:04:39PM +0100, Yannick Fertre wrote:
> From: Yannick Fertre <yfertre.stm32@gmail.com>

"dt-bindings: watchdog: ..." for subject.
> 
> This adds documentation of device tree bindings for the STM32 IWDG
> (Independent WatchDoG).
> 
> Change-Id: Idadacc806d00205fe9af2e8606af229b4b760558
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

watchdog at ...

> +	compatible = "st,stm32-iwdg";
> +	reg = <0x40003000 0x400>;
> +	clocks = <&clk_lsi>;
> +};
> -- 
> 1.9.1
> 
