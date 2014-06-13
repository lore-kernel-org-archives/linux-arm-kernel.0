From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 15:34:44 +0200
Subject: [PATCH v2] ARM: Remove ARCH_HAS_CPUFREQ config option
In-Reply-To: <1401819863-20296-1-git-send-email-sboyd@codeaurora.org>
References: <1401819863-20296-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201406131534.44741.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 June 2014, Stephen Boyd wrote:
> This config exists entirely to hide the cpufreq menu from the
> kernel configuration unless a platform has selected it. Nothing
> is actually built if this config is 'Y' and it just leads to more
> patches that add a select under a platform Kconfig so that some
> other CPUfreq option can be chosen. Let's remove the option so
> that we can always enable CPUfreq drivers on ARM platforms.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied to fixes branch, thanks!

	Arnd
