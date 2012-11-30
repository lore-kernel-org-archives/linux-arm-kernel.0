From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 30 Nov 2012 11:52:09 +0100
Subject: [PATCH] mfd: ab8500-core: Fix invalid free of devm_ allocated data
In-Reply-To: <1353673123-32340-1-git-send-email-tushar.behera@linaro.org>
References: <1353673123-32340-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <20121130105209.GL3176@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On Fri, Nov 23, 2012 at 05:48:43PM +0530, Tushar Behera wrote:
> The objects allocated by devm_* APIs are managed by devres and are
> freed when the device is detached. Hence there is no need to remove
> them explicitly in remove function.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
