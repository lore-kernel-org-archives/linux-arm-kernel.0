From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 4 Apr 2013 11:06:23 +0100
Subject: [PATCH 2/2] mfd: db8500-prcmu: Support platform dependant device
 selection
In-Reply-To: <1365067877-29459-2-git-send-email-lee.jones@linaro.org>
References: <1365067877-29459-1-git-send-email-lee.jones@linaro.org>
 <1365067877-29459-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20130404100623.GB8921@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 04 Apr 2013, Lee Jones wrote:

> The main aim for this cycle is to have the u8540 booting to a
> console. However, the u8540 doesn't support all of the u8500
> platform devices yet. After this stage is complete we can then
> fill in the inadequacies, such as specific clock support at a
> later date. To achieve this we're placing devices supported by
> all platforms into a common device structure and the remaining
> ones into a platform specific one.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   46 +++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 16 deletions(-)

Withdrawn.

I'll resubmit.

Sorry for the churn.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
