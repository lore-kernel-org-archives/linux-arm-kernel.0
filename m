From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 29 Jul 2014 12:32:38 +0200
Subject: [PATCH v8 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
In-Reply-To: <1406611711-25112-5-git-send-email-thomas.ab@samsung.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
 <1406611711-25112-5-git-send-email-thomas.ab@samsung.com>
Message-ID: <53D77846.4060700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.07.2014 07:28, Thomas Abraham wrote:
> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> which did not have CPUfreq driver support, enable the use of generic
> CPUfreq driver.
> 
> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
