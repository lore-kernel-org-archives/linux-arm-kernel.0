From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 22 May 2014 21:01:15 +0200
Subject: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
In-Reply-To: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
Message-ID: <537E497B.9020404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
> This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
> vexpress: Use wfi macro in platform_do_lowpower.")
>
> Current Exynos CPU hotplug code includes a hardcoded WFI
> instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> mode, this is invalid and causes the machine to hang hard when a CPU
> is offlined.
>
> Use wfi macro instead of the hardcoded WFI instruction.
>
> Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
