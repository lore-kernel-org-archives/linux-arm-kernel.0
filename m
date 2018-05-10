From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 10 May 2018 11:51:38 +0200
Subject: [PATCH 0/2] Revert explicit support for Renesas R-Car Gen 3
 r8a779[56] SoCs
In-Reply-To: <20180502095806.30341-1-horms+renesas@verge.net.au>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
Message-ID: <2473510.IAjYrYimeR@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 2, 2018 11:58:04 AM CEST Simon Horman wrote:
> Revert commits that added explicit support for Renesas R-Car Gen 3
> r8a779[56] SoCs to the generic cpufreq driver.
> 
> This is no longer needed since the flowing commit and to the best of my
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
> 
> 

Am I expected to pick up this series?

Thanks,
Rafael
