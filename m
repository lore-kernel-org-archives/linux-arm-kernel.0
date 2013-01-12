From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 12 Jan 2013 14:34:24 +0100
Subject: [PATCH v2 0/2] Add imx6q-cpufreq driver support
In-Reply-To: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1615305.5RaFjClze9@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 10, 2013 04:34:21 PM Shawn Guo wrote:
> Changes since v1:
>  - Drop patch "PM / OPP: Export more symbols for module usage", as
>    there is already one "[PATCH 5/6 v9] power: export opp cpufreq
>    functions" from Mark Langsdorf.
>  - Instead of having cpu_dev be the struct device retrieved from
>    get_cpu_device(), have it be &pdev->dev, so that we can use managed
>    functions to simplified the cleanup path.
>  - Use dev_* rather than pr_* for message output
>  - Fix Typos and others commented by Viresh and Sascha. 
> 
> Once the first patch gets accepted, I will apply the second one for
> going through arm-soc tree.
> 
> Shawn Guo (2):
>   cpufreq: add imx6q-cpufreq driver
>   ARM: imx: enable imx6q-cpufreq support

I would prefer these two to go through the arm-soc tree if that's not a problem.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
