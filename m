From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 5 Oct 2018 09:23:32 +0530
Subject: [PATCH v4 4/6] clk: qoriq: Add clockgen support for lx2160a
In-Reply-To: <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <20181005035332.4ogmxyxiwisok7xs@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-10-18, 06:33, Vabhav Sharma wrote:
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3d773f6..83921b7 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },
>  	{ .compatible = "fsl,ls2080a-clockgen", },
> +	{ .compatible = "fsl,lx2160a-clockgen", },
>  	{ .compatible = "fsl,p4080-clockgen", },
>  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
>  	{ .compatible = "fsl,qoriq-clockgen-2.0", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
