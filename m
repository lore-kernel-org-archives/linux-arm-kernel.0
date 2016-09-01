From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 1 Sep 2016 19:30:28 +0300
Subject: [PATCH 1/3] ARM: dts: r7s72100: add ethernet clock to device tree
In-Reply-To: <20160901155430.23400-1-chris.brandt@renesas.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
Message-ID: <aaf8c5de-a4f8-42e5-583d-c81a9d92edae@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2016 06:54 PM, Chris Brandt wrote:

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  include/dt-bindings/clock/r7s72100-clock.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
> index 5128f4d..3cd8138 100644
> --- a/include/dt-bindings/clock/r7s72100-clock.h
> +++ b/include/dt-bindings/clock/r7s72100-clock.h
> @@ -25,6 +25,9 @@
>  #define R7S72100_CLK_SCIF6	1
>  #define R7S72100_CLK_SCIF7	0
>
> +/* MSTP7 */
> +#define R7S72100_CLK_ETHER	4
> +
>  /* MSTP9 */
>  #define R7S72100_CLK_I2C0	7
>  #define R7S72100_CLK_I2C1	6

    I'd add the MSTP7 clock node itself in the same patch...

MBR, Sergei
