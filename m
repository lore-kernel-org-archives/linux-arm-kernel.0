From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 09:22:11 +0800
Subject: [RFC PATCH 06/11] cpufreq: imx6q-cpufreq: remove device tree
 parsing for cpu nodes
In-Reply-To: <1373883732-26303-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1373883732-26303-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130716012209.GA28375@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:22:07AM +0100, Sudeep.KarkadaNagesha at arm.com wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Now that the cpu device registration initialises the of_node(if available)
> appropriately for all the cpus, parsing here is redundant.
> 
> This patch removes all DT parsing and uses cpu->of_node instead.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  arch/arm/mach-imx/mach-imx6q.c  | 3 +--
>  drivers/cpufreq/imx6q-cpufreq.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
