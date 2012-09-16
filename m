From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 17 Sep 2012 01:45:34 +0200
Subject: [PATCH 17/19] mfd: Enable the tc3589x for Device Tree
In-Reply-To: <1347016499-29354-18-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20120916234534.GQ3647@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Sep 07, 2012 at 12:14:57PM +0100, Lee Jones wrote:
> Here we provide a means to probe and extract vital information
> from Device Tree when booting with it enabled. Without this
> patch sub-devices wouldn't be able to reference the tc3589x
> from Device Tree.
> 
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/tc3589x.c |   43 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
