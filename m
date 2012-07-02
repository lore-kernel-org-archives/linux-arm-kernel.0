From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 02 Jul 2012 16:23:34 +0100
Subject: [PATCH 02/14] rtc: Ensure correct probing of the AB8500 RTC when
 Device Tree is enabled
In-Reply-To: <1339428307-3850-3-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-3-git-send-email-lee.jones@linaro.org>
Message-ID: <4FF1BCF6.1090608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 16:24, Lee Jones wrote:
> Without this patch, if Device Tree is enabled the AB8500 RTC wouldn't
> get probed at all, as there is no reference to it from platform code.
> This patch ensures the driver is probed during normal DT start-up.
>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/rtc/rtc-ab8500.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Please don't take this patch now, it was been superseded.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
