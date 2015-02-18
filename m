From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Feb 2015 15:17:31 -0600
Subject: [PATCH 1/2] Documentation: bindings: add optional fifo size
 property to AMBA UARTs
In-Reply-To: <1424290069-8760-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424290069-8760-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <CAL_JsqKBxmEUCYz4Pw6wbBTvU8p7Fo5O05tLUi9SHoiAzdVRgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 2:07 PM, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/serial/pl011.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
> index 5d2e840..05d1adb 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.txt
> +++ b/Documentation/devicetree/bindings/serial/pl011.txt
> @@ -13,5 +13,6 @@ Optional properties:
>  - dmas:           When present, may have one or two dma channels.
>            The first one must be named "rx", the second one
>            must be named "tx".
> +- fifo-size:  When present, must have the fifo size.
>
>  See also bindings/arm/primecell.txt
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
