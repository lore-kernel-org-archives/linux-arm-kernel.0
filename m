From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 22:56:09 +0200
Subject: [rtc-linux] [PATCH 02/14] rtc: Ensure correct probing of the
 AB8500 RTC when Device Tree is enabled
In-Reply-To: <1339428307-3850-3-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbOYOWi-0gu_4eUZzkZmNw-oVOuVEpdaPqqWSV2rLRoDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Without this patch, if Device Tree is enabled the AB8500 RTC wouldn't
> get probed at all, as there is no reference to it from platform code.
> This patch ensures the driver is probed during normal DT start-up.
>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
