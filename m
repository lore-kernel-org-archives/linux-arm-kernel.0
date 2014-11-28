From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 11:30:29 +0100
Subject: [PATCH 4/6] arm: iop: specify PMUs are for XScale CPUs
In-Reply-To: <1416397800-12457-5-git-send-email-mark.rutland@arm.com>
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
 <1416397800-12457-5-git-send-email-mark.rutland@arm.com>
Message-ID: <CACRpkdY5HPSWpryZLQV_Q6QpH20Prodwq-f7gqpZpFjum-yUfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 12:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> Now that we can specify which PMU variant we're likely to deal with, do
> so in the iop board code. This will allow us to split the ARMv6, ARMv7,
> and XScale PMU drivers.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
