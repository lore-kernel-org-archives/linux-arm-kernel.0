From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 2 Nov 2016 10:15:03 +0530
Subject: [PATCH v3 0/4] PXA cpufreq conversion to clock API
In-Reply-To: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161102044503.GC10786@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31-10-16, 20:54, Robert Jarzmik wrote:
> Hi,
> 
> This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
> API, next iteration.
> 
> The first 3 patches are review and merge material :
>  - patch 1/4 for Viresh and Rafael
>  - patches 2/4 and 3/4 for me
> 
> The 4th on is for review but not merge, as the clock changes must be fully
> reviewed and go in first as a prequisite
> 
> Since previous iteration, 2 and 3 were amended per Viresh's suggestion.
> 
> Robert Jarzmik (4):
>   cpufreq: pxa: use generic platdev driver for device-tree
>   ARM: dts: pxa: add pxa25x cpu operating points
>   ARM: dts: pxa: add pxa27x cpu operating points
>   cpufreq: pxa: convert to clock API
> 
>  arch/arm/boot/dts/pxa25x.dtsi        |  25 +++++
>  arch/arm/boot/dts/pxa27x.dtsi        |  40 ++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/pxa2xx-cpufreq.c     | 191 +++++++----------------------------
>  4 files changed, 106 insertions(+), 152 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
