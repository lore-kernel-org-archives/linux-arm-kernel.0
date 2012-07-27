From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 27 Jul 2012 15:36:10 +0200
Subject: [PATCH 3/7] mfd: db8500-prcmu: Ensure AB8500 platform data is
 passed through MFD Core
In-Reply-To: <1343392734-11805-4-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20120727133610.GP16859@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Jul 27, 2012 at 01:38:50PM +0100, Lee Jones wrote:
> When booting via platform code the AB8500 platform data is now passed
> in though the DB8500. However, if pdata_size is not set it will not be
> subsequently passed onto subordinate devices. This patch correctly
> populates pdata_size.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |    1 +
>  1 file changed, 1 insertion(+)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
