From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 Mar 2017 16:01:28 +0100
Subject: [PATCH v2 05/18] arm64: cpu_errata: Add capability to advertise
 Cortex-A73 erratum 858921
In-Reply-To: <20170320174829.28182-6-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-6-marc.zyngier@arm.com>
Message-ID: <20170322150128.GD30499@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 05:48:16PM +0000, Marc Zyngier wrote:
> In order to work around Cortex-A73 erratum 858921 in a subsequent
> patch, add the required capability that advertise the erratum.
> 
> As the configuration option it depends on is not present yet,
> this has no immediate effect.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
