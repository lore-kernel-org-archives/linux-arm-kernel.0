From: dirk.behme@gmail.com (Dirk Behme)
Date: Tue, 15 Dec 2015 09:39:17 +0100
Subject: [PATCH] arm64: perf: Correct Cortex-A53/A57 compatible values
In-Reply-To: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
References: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
Message-ID: <566FD1B5.2070602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.12.2015 09:33, Geert Uytterhoeven wrote:
> Use commas instead of periods.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Dirk Behme <dirk.behme@gmail.com>

Thanks!

Dirk

> ---
>   Documentation/devicetree/bindings/arm/pmu.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 97ba45af04fc693f..a6cd14888bed9b29 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -9,8 +9,8 @@ Required properties:
>   - compatible : should be one of
>   	"apm,potenza-pmu"
>   	"arm,armv8-pmuv3"
> -	"arm.cortex-a57-pmu"
> -	"arm.cortex-a53-pmu"
> +	"arm,cortex-a57-pmu"
> +	"arm,cortex-a53-pmu"
>   	"arm,cortex-a17-pmu"
>   	"arm,cortex-a15-pmu"
>   	"arm,cortex-a12-pmu"
>
