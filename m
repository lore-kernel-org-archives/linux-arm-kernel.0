From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Mar 2013 10:11:07 +0530
Subject: [PATCH 04/15] cpuidle: OMAP4: remove timer broadcast
 initialization
In-Reply-To: <1364234140-514-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <515126E3.5050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013 11:25 PM, Daniel Lezcano wrote:
> The initialization is done from the cpuidle framework.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
