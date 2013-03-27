From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 21:37:32 +0800
Subject: [PATCH v2 1/5] cpufreq: cpufreq-cpu0: Fix documentation example
In-Reply-To: <1364389294-1997-2-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
 <1364389294-1997-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130327133731.GE2674@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 02:01:30PM +0100, Markus Pargmann wrote:
> The example includes a property 'transition-latency', which should be
> clock-latency.
> 

Viresh already sent a fix [1] for that.

Shawn

[1] https://lkml.org/lkml/2013/3/26/267

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> index 4416ccc..051f764 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> @@ -32,7 +32,7 @@ cpus {
>  			396000  950000
>  			198000  850000
>  		>;
> -		transition-latency = <61036>; /* two CLK32 periods */
> +		clock-latency = <61036>; /* two CLK32 periods */
>  	};
>  
>  	cpu at 1 {
> -- 
> 1.8.1.5
> 
