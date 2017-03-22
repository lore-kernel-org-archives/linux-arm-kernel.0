From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 Mar 2017 10:22:28 +0100
Subject: [PATCH v2 01/18] arm64: Allow checking of a CPU-local erratum
In-Reply-To: <20170320174829.28182-2-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-2-marc.zyngier@arm.com>
Message-ID: <20170322092228.GA30499@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 05:48:12PM +0000, Marc Zyngier wrote:
> this_cpu_has_cap() only checks the feature array, and not the errata
> one. In order to be able to check for a CPU-local erratum, allow it
> to inspect the latter as well.
> 
> This is consistent with cpus_have_cap()'s behaviour, which includes
> errata already.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
