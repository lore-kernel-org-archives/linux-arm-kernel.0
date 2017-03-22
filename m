From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 Mar 2017 16:47:51 +0100
Subject: [PATCH v2 09/18] arm64: arch_timer: Move
 arch_timer_reg_read/write around
In-Reply-To: <20170320174829.28182-10-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-10-marc.zyngier@arm.com>
Message-ID: <20170322154751.GF30499@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 05:48:20PM +0000, Marc Zyngier wrote:
> As we're about to move things around, let's start with the low
> level read/write functions. This allows us to use these functions
> in the errata handling code without having to use forward declaration
> of static functions.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
