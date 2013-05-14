From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:49:14 +0200
Subject: [PATCH] mfd: ab8500-sysctrl: Always enable pm_power_off handler
In-Reply-To: <1368097688-17858-1-git-send-email-fabio.baltieri@linaro.org>
References: <1368097688-17858-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdYXAB03=bqAQ8OZ8wZ7Q9j+LwH-Uwtijw49OjXt70yiXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 1:08 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> AB8500 sysctrl driver implements a pm_power_off handler, but that is
> currently not registered until a specific platform data field is
> enabled.
>
> This patch drops the platform data field and always registers
> ab8500_power_off if no other pm_power_off handler was defined before,
> and also introduces the necessary cleanup code in the driver's remove
> function.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
