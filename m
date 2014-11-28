From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 11:29:58 +0100
Subject: [PATCH 1/6] arm: realview: specify PMU types
In-Reply-To: <1416397800-12457-2-git-send-email-mark.rutland@arm.com>
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
 <1416397800-12457-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CACRpkdbV_iAXAv8yEY731sEHrvkDXx5k6xfBD8L0ssu_p7HGLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 12:49 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> Now that we can specify which PMU variant we're likely to deal with, do
> so in the realview board code. This will allow us to split the ARMv6,
> ARMv7, and XScale PMU drivers.
>
> The Realview EB may be used with ARMv6 or ARMv7 CPUs, but luckily
> there's only a single ARMv7 CPU, so we can match that explicitly to
> determine whether or not we have an ARMv7 PMU.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
