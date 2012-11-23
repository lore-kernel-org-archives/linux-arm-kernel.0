From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 23 Nov 2012 12:18:36 +0100
Subject: [PATCH 2/2] mfd: ab8500-core: Add abx500-clk as an mfd child
 device
In-Reply-To: <1353580540-3774-3-git-send-email-ulf.hansson@stericsson.com>
References: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
 <1353580540-3774-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121123111836.GE12685@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, Nov 22, 2012 at 11:35:40AM +0100, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Hierarchically, the abx500-clk shall be considered as a child of the
> ab8500 core. The abx500-clk is intiated at arch init and thus the clks
> will be available when clients needs them.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c |    4 ++++
>  1 file changed, 4 insertions(+)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
