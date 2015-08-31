From: sonnyrao@chromium.org (Sonny Rao)
Date: Mon, 31 Aug 2015 15:23:47 -0700
Subject: [PATCH v2 3/5] Documentation: arm-pl330: add description of arm,
 pl330-broken-no-flushp
In-Reply-To: <1440722292-31721-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440722176-31588-1-git-send-email-shawn.lin@rock-chips.com>
 <1440722292-31721-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAPz6YkVdGp_Qu=uoZWY10R_DxyWocxM_Sw4L2epdcerkrgWjUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 5:38 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - add Reviewed-by: Doug Anderson <dianders@chromium.org>
> - reorder this patch before the usage of the quirk
>
> Changes in v1:
> - rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
>   by Krzysztof.
>
>  Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> index 2675658..db7e226 100644
> --- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> @@ -15,6 +15,7 @@ Optional properties:
>      cells in the dmas property of client device.
>    - dma-channels: contains the total number of DMA channels supported by the DMAC
>    - dma-requests: contains the total number of DMA requests supported by the DMAC
> +  - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
>
>  Example:
>
> --
> 2.3.7

Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
