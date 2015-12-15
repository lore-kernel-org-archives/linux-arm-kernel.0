From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 10:37:00 +0000
Subject: [PATCH] arm64: perf: Correct Cortex-A53/A57 compatible values
In-Reply-To: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
References: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151215103659.GB31299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 09:33:20AM +0100, Geert Uytterhoeven wrote:
> Use commas instead of periods.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/devicetree/bindings/arm/pmu.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 97ba45af04fc693f..a6cd14888bed9b29 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -9,8 +9,8 @@ Required properties:
>  - compatible : should be one of
>  	"apm,potenza-pmu"
>  	"arm,armv8-pmuv3"
> -	"arm.cortex-a57-pmu"
> -	"arm.cortex-a53-pmu"
> +	"arm,cortex-a57-pmu"
> +	"arm,cortex-a53-pmu"
>  	"arm,cortex-a17-pmu"
>  	"arm,cortex-a15-pmu"
>  	"arm,cortex-a12-pmu"
> -- 
> 1.9.1
> 
