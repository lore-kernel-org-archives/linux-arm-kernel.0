From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:22:12 +0200
Subject: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency
 warning
In-Reply-To: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201306072122.12369.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Daniel Lezcano wrote:
> Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
> ARCH_NEEDS_CPU_IDLE_COUPLED option was wrongly not depending on the CPU_IDLE
> and the Kconfig for OMAP / TEGRA was not checking this dependency when setting
> the option.
> 
> With this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED has been moved under the
> CPU_IDLE option. The dependency has been fixed in the relevant arch's Kconfig.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
