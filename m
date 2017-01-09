From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 20:38:03 +0100
Subject: [PATCH 1/4] watchdog: coh901327_wdt: Simplify error handling in
 probe function
In-Reply-To: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Checking if there is no error followed by a goto if there is one is
> confusing. Reverse the logic.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
