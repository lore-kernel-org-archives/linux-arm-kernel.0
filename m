From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 2 May 2018 15:33:15 +0530
Subject: [PATCH 0/2] Revert explicit support for Renesas R-Car Gen 3
 r8a779[56] SoCs
In-Reply-To: <20180502095806.30341-1-horms+renesas@verge.net.au>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
Message-ID: <20180502100315.aydjezp4flmnwu2j@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-05-18, 11:58, Simon Horman wrote:
> Revert commits that added explicit support for Renesas R-Car Gen 3
> r8a779[56] SoCs to the generic cpufreq driver.
> 
> This is no longer needed since the flowing commit and to the best of my

s/flowing/following ?

Same thing in the patches as well.

> knowledge is not relied on by any upstream DTS: edeec420de24 ("cpufreq:
> dt-platdev: Automatically create cpufreq device with OPP v2")
> 
> Simon Horman (2):
>   Revert "cpufreq: dt: Add r8a7796 support to to use generic cpufreq
>     driver"
>   Revert "cpufreq: rcar: Add support for R8A7795 SoC"
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
