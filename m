From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 Mar 2017 15:57:34 +0100
Subject: [PATCH v2 04/18] arm64: cpu_errata: Allow an erratum to be match
 for all revisions of a core
In-Reply-To: <20170320174829.28182-5-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-5-marc.zyngier@arm.com>
Message-ID: <20170322145734.GC30499@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 05:48:15PM +0000, Marc Zyngier wrote:
> Some minor erratum may not be fixed in further revisions of a core,
> leading to a situation where the workaround needs to be updated each
> time an updated core is released.
> 
> Introduce a MIDR_ALL_VERSIONS match helper that will work for all
> versions of that MIDR, once and for all.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
