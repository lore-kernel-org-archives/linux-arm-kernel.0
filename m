From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 5 Dec 2016 11:06:30 +0100
Subject: [PATCH 2/8] dt-bindings: document the STM32 RTC bindings
In-Reply-To: <1480687801-19525-4-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <20161205100630.n3gldznf524pucjm@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/12/2016 at 15:09:55 +0100, Amelie Delaunay wrote :
> This patch adds documentation of device tree bindings for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> new file mode 100644
> index 0000000..4578838
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> @@ -0,0 +1,31 @@
> +STM32 Real Time Clock
> +
> +Required properties:
> +- compatible: "st,stm32-rtc".
> +- reg: address range of rtc register set.
> +- clocks: reference to the clock entry ck_rtc.
> +- clock-names: name of the clock used. Should be "ck_rtc".

Is this name really useful?

> +- interrupt-parent: phandle for the interrupt controller.
> +- interrupts: rtc alarm interrupt.
> +- interrupt-names: rtc alarm interrupt name, should be "alarm".

Same comment, is this name really useful?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
