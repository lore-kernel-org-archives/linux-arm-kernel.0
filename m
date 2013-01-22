From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 22 Jan 2013 04:26:11 +0100
Subject: [PATCH 1/3] mfd: Fix compile errors and warnings when
 !CONFIG_AB8500_BM
In-Reply-To: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130122032611.GK7409@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jan 09, 2013 at 10:06:03AM +0000, Lee Jones wrote:
> drivers/mfd/ab8500-core.c:1015:21: error: ?ab8500_bm_data? undeclared here
> 
> include/linux/mfd/abx500/ab8500-bm.h:445:13: warning: ?ab8500_fg_reinit? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:448:13: warning: ?ab8500_charger_usb_state_changed? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:451:29: warning: ?ab8500_btemp_get? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:455:12: warning: ?ab8500_btemp_get_batctrl_temp? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:463:12: warning: ?ab8500_fg_inst_curr_blocking? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:442:12: warning: ?ab8500_fg_inst_curr_done? defined but not used
> include/linux/mfd/abx500/ab8500-bm.h:447:26: warning: ?ab8500_fg_get? defined but not used
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c            |    1 +
>  include/linux/mfd/abx500.h           |    2 --
>  include/linux/mfd/abx500/ab8500-bm.h |   29 ++++-------------------------
>  3 files changed, 5 insertions(+), 27 deletions(-)
Applied to my for-linus branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
