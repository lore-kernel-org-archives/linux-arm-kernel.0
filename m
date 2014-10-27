From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Oct 2014 17:03:21 +0100
Subject: [PATCH] mfd: ab8500-sysctrl: Drop ab8500_restart
In-Reply-To: <1412871518-11359-1-git-send-email-linux@roeck-us.net>
References: <1412871518-11359-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkda=EBPS7Xb5je+eZ2mPqV1xbEAKbaSEcM5BbAX3iCLYSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 9, 2014 at 6:18 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> ab8500_restart is not called from anywhere in the kernel, so drop it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Yeah I guess... cannot argue with that.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
