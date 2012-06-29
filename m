From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 15:24:19 +0200
Subject: [PATCH 18/22] mfd: Remove redundant Kconfig entry
In-Reply-To: <1338353260-10097-19-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629132419.GM4846@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, May 30, 2012 at 12:47:36PM +0800, Lee Jones wrote:
> During ab8500-core clean-up the Kconfig entry for AB8500_I2C_CORE
> was left remnant. This patch simply removes it.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig |   10 ----------
>  1 file changed, 10 deletions(-)
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
