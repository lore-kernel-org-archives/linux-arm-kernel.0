From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 15:21:25 +0200
Subject: [PATCH 16/22] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when
 requesting a threaded IRQ
In-Reply-To: <1338353260-10097-17-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-17-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629132125.GL4846@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, May 30, 2012 at 12:47:34PM +0800, Lee Jones wrote:
> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-gpadc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
