From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 20:39:58 +0100
Subject: [PATCH 4/4] watchdog: coh901327_wdt: Use dev variable instead of
 pdev->dev
In-Reply-To: <1483500343-27113-4-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
 <1483500343-27113-4-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdbsZB-yKCY-fzLw-OK6YmXycTKF5Hep094W8HbQxj+ptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Use a local dev variable instead of dereferencing pdev->dev several
> times in the probe function to make the code easier to read.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
