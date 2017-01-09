From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 20:39:28 +0100
Subject: [PATCH 3/4] watchdog: coh901327_wdt: Use devm_ioremap_resource to
 map resources
In-Reply-To: <1483500343-27113-3-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
 <1483500343-27113-3-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkda1aTWaj1gN_y2L_yD8T9rFX4K7aL3+BukTjq1MRD7E6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Map resources using devm_ioremap_resource() to simplify error handling.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
