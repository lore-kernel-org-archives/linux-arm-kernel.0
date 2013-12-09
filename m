From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 14:27:30 +0100
Subject: [PATCH 2/3] ARM: SAMSUNG: Let s3c_pm_do_restore_*() take const
 sleep_save
In-Reply-To: <1384971686-7208-2-git-send-email-djkurtz@chromium.org>
References: <1384971686-7208-1-git-send-email-djkurtz@chromium.org>
 <1384971686-7208-2-git-send-email-djkurtz@chromium.org>
Message-ID: <1388884.PZXKrtOKJT@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thursday 21 of November 2013 02:21:25 Daniel Kurtz wrote:
> The restore functions do not modify the passed in struct sleep_save,
> so that parameter can be const.
> 
> This allows us to pass in const struct.  This allows us to use const
> structs sleep_save to define system registers that will always be
> restored to a constant value.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/arm/plat-samsung/include/plat/pm.h | 4 ++--
>  arch/arm/plat-samsung/pm.c              | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
