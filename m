From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 10 Jul 2012 11:13:04 +0200
Subject: [PATCH 1/1] mfd: ab8500: Clean-up the last two ab8500 related DT
 match tables
In-Reply-To: <1341578598-9307-1-git-send-email-lee.jones@linaro.org>
References: <1341578598-9307-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120710091304.GU15345@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Jul 06, 2012 at 01:43:18PM +0100, Lee Jones wrote:
> A patch was recently submitted to stop all ab8500 devices from
> being registered through Device Tree. Instead, only the db8500
> will be DT:ed and the rest will continue to be registered via
> the MFD API, as they always were.
> 
> Two patches have recently been applied which enable Device Tree
> probing; one for rtc-ab8500 and the other for ponkey-ab8500.
> These two need to be removed to prevent double-probing these
> devices with Device Tree is enabled.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/input/misc/ab8500-ponkey.c |    8 --------
>  drivers/rtc/rtc-ab8500.c           |    6 ------
>  2 files changed, 14 deletions(-)
I don't know against which tree you generated those patches, but none of those
2 of_device_id arrays are in my for-next branch. So I can't apply this patch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
