From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 16:51:10 +0200
Subject: [PATCH 07/14] mfd: Initialise the AB8500 driver at core_initcall
 time
In-Reply-To: <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629145110.GC22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jun 11, 2012 at 04:25:00PM +0100, Lee Jones wrote:
> The AB8500 is soon to have its own IRQ domain. For this to be useful
> the driver needs to be initialised earlier in the boot sequence. Here
> we move initialisation forward from arch_initcall to core_initcall time.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
