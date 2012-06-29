From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 17:09:24 +0200
Subject: [PATCH 04/15] mfd: ab8500: Register devices using the newly
 DT:ed MFD API
In-Reply-To: <1340197011-5435-5-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629150924.GG22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 20, 2012 at 01:56:40PM +0100, Lee Jones wrote:
> Now the MFD API is Device Tree aware we can use it for platform
> registration again, even when booting with DT enabled. To aid in
> Device Node pointer allocation we provide each cell with the
> associative compatible string.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    1 -
>  drivers/input/misc/ab8500-ponkey.c |    6 ----
>  drivers/mfd/ab8500-core.c          |   64 ++++++++++++++++++++++--------------
>  drivers/mfd/ab8500-debugfs.c       |    6 ----
>  drivers/mfd/ab8500-gpadc.c         |    6 ----
>  drivers/mfd/ab8500-sysctrl.c       |    6 ----
>  drivers/misc/ab8500-pwm.c          |    6 ----
>  drivers/regulator/ab8500.c         |    6 ----
>  drivers/rtc/rtc-ab8500.c           |    7 ----
>  drivers/usb/otg/ab8500-usb.c       |    6 ----
>  10 files changed, 39 insertions(+), 75 deletions(-)
This one does not apply properly against my for-next branch. Could you please
generate a new one for me ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
