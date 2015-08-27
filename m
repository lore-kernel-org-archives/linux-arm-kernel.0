From: dianders@chromium.org (Doug Anderson)
Date: Thu, 27 Aug 2015 09:53:28 -0700
Subject: [PATCH v1 5/5] Documentation: arm-pl330: add description of arm,
 pl330-broken-no-flushp
In-Reply-To: <1440685505-22247-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440685419-22037-1-git-send-email-shawn.lin@rock-chips.com>
 <1440685505-22247-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAD=FV=W8nYeTuTZ7AB2o1sV=M-SjdwHuj1RoZ15wnKKS3NEpeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 27, 2015 at 7:25 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
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

Seems fine except that it should be higher up in the list of patches...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
