From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 May 2017 11:20:30 -0600
Subject: [PATCH v9 3/9] doc: Add coresight_cpu_debug.enable to
 kernel-parameters.txt
In-Reply-To: <1494298202-6739-4-git-send-email-leo.yan@linaro.org>
References: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
 <1494298202-6739-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20170511172030.GD22627@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 10:49:56AM +0800, Leo Yan wrote:
> Add coresight_cpu_debug.enable to kernel-parameters.txt, this flag is
> used to enable/disable the CPU sampling based debugging.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e4c9e0e..010ae02 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -649,6 +649,13 @@
>  			/proc/<pid>/coredump_filter.
>  			See also Documentation/filesystems/proc.txt.
>  
> +	coresight_cpu_debug.enable
> +			[ARM,ARM64]
> +			Format: <bool>
> +			Enable/disable the CPU sampling based debugging.
> +			0: default value, disable debugging
> +			1: enable debugging at boot time
> +
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
>  
> -- 
> 2.7.4
> 
