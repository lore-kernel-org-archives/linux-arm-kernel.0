From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 20 Apr 2016 10:42:41 -0700
Subject: [PATCH 09/14] Input: touchscreen: Broadcom iProc: DT spelling
 s/clock-name/clock-names/
In-Reply-To: <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
Message-ID: <20160420174241.GA28831@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 05:32:14PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

> ---
>  .../devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> index 25541f30e38701f2..ac5dff412e25266f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> @@ -7,7 +7,7 @@ Required properties:
>    If this property is selected please make sure MFD_SYSCON config
>    is enabled in the defconfig file.
>  - clocks:  The clock provided by the SOC to driver the tsc
> -- clock-name:  name for the clock
> +- clock-names:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
>  - address-cells: Specify the number of u32 entries needed in child nodes.
>    Should set to 1.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
