From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 15:20:19 -0600
Subject: [PATCH] devicetree: bindings: clk: mvebu: fix description for
 sata1 on Armada XP
In-Reply-To: <20161220212005.26139-1-uwe@kleine-koenig.org>
References: <20161220212005.26139-1-uwe@kleine-koenig.org>
Message-ID: <20161222212019.t52jy4h5cczsah7z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 10:20:05PM +0100, Uwe Kleine-K?nig wrote:
> SATA Host 0 clock is (as correctly documented) id 15/sata0.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
>  Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob

> 
> diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
> index cb8542d910b3..5142efc8099d 100644
> --- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
> @@ -117,7 +117,7 @@ ID	Clock	Peripheral
>  25	tdm	Time Division Mplx
>  28	xor1	XOR DMA 1
>  29	sata1lnk
> -30	sata1	SATA Host 0
> +30	sata1	SATA Host 1
>  
>  The following is a list of provided IDs for Dove:
>  ID	Clock	Peripheral
> -- 
> 2.10.2
> 
