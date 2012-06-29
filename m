From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 16:48:19 +0200
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629144819.GB22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jun 11, 2012 at 04:24:59PM +0100, Lee Jones wrote:
> Now the AB8500 has its own IRQ domain it needs to be initialised earlier
> in the boot sequence. As the AB8500 relies on the DB8500 PRCMU we need to
> reflect this change for the PRCMU driver too.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
