From: javi.merino@arm.com (Javi Merino)
Date: Tue, 8 Jul 2014 14:56:14 +0100
Subject: [PATCH] thermal: Add missing cpumask_clear
In-Reply-To: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
References: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
Message-ID: <20140708135613.GD2796@e104805>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 11:22:40AM +0100, Jonghwan Choi wrote:
> Cpumasks should be cleared before using.
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  drivers/thermal/db8500_cpufreq_cooling.c        |    1 +
>  drivers/thermal/imx_thermal.c                   |    1 +
>  drivers/thermal/samsung/exynos_thermal_common.c |    1 +
>  3 files changed, 3 insertions(+)

Reviewed-by: Javi Merino <javi.merino@arm.com>

You should send this patch to linux-pm, I think it should go via the
thermal tree.

Cheers,
Javi
