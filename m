From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 12:07:51 +0200
Subject: [PATCH 3/3] mfd: ab8500: sysctrl: Initialize driver at
 arch_initcall
In-Reply-To: <1364943987-1338-4-git-send-email-ulf.hansson@stericsson.com>
References: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
 <1364943987-1338-4-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130409100751.GR24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Apr 03, 2013 at 01:06:27AM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The abx500-clk driver is initiated at arch_initcall level. Moreover it
> is relying on the ab8500-sysctrl API to be available. Therefore move
> ab8500-sysctrl to arch_initcall level as well. The device is already
> added before the abx500 clk device, thus it will be probed before as
> well, which is exactly what we want.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/ab8500-sysctrl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
