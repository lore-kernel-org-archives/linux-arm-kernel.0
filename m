From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Aug 2015 21:59:57 +0900
Subject: [PATCH 5/5] Documentation: arm-pl330: add description of
 broken-no-flushp
In-Reply-To: <1440665362-31771-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
 <1440665362-31771-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAJKOXPfPLu09ZGChTRr+9-m_HLruYN6KvT=bvMrYrndCBtN2Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-27 17:49 GMT+09:00 Shawn Lin <shawn.lin@rock-chips.com>:
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> index 2675658..0f19268 100644
> --- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> @@ -15,6 +15,7 @@ Optional properties:
>      cells in the dmas property of client device.
>    - dma-channels: contains the total number of DMA channels supported by the DMAC
>    - dma-requests: contains the total number of DMA requests supported by the DMAC
> +  - broken-no-flushp: quirk for avoiding to execute DMAFLUSHP

It looks like a device or vendor specific quirk so the property should
have a prefix. For example:
arm,pl330-broken-no-flushp

Best regards,
Krzysztof
