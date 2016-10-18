From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Oct 2016 17:10:25 +0530
Subject: [PATCH v2 4/4] cpufreq: pxa: convert to clock API
In-Reply-To: <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161018114025.GD11471@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-10-16, 21:57, Robert Jarzmik wrote:
> As the clock settings have been introduced into the clock pxa drivers,
> which are now available to change the CPU clock by themselves, remove
> the clock handling from this driver, and rely on pxa clock drivers.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: added !OF Kconfig dependency
> ---
>  drivers/cpufreq/Kconfig.arm      |   2 +-
>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
>  2 files changed, 40 insertions(+), 153 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
