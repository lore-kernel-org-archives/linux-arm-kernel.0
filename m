From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 1 Feb 2017 11:08:07 +0100
Subject: [PATCH 3/7] arm64: arm_arch_timer: remove fsl-a008585 parameter
In-Reply-To: <1485865196-12742-4-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
 <1485865196-12742-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20170201100807.GM2206@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:19:52PM +0000, Mark Rutland wrote:
> From: Ding Tianhong <dingtianhong@huawei.com>
> 
> Having a command line option to flip the errata handling for a
> particular erratum is a little bit unusual, and it's vastly superior to
> pass this in the DT. By common consensus, it's best to kill off the
> command line parameter.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> [Mark: split patch, reword commit message]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
