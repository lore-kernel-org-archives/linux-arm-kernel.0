From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 23 Aug 2011 11:00:36 +0200
Subject: [PATCH] mach-pnx4008: rename GPIO header
In-Reply-To: <1314086706-28705-1-git-send-email-linus.walleij@stericsson.com>
References: <1314086706-28705-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAMJBoFPLbm96qiyFFmNMMGK5UhPjabFrwOrwtDROspLnjg5ang@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 10:05 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The PNX4008 header file is using the generic gpio and gpiolib
> namespace in <mach/gpio.h> yet the GPIO interface is not generic
> at all so rename it to <mach/gpio-pnx4008.h>
>
> This fixes a build failure in current -next: the includes were
> changed from <mach/gpio.h> to <linux/gpio.h> but since this
> platform isn't using generic gpio <linux/gpio.h> did not include
> <mach/gpio.h> and things broke apart.
>
> Cc: Vitaly Wool <vitalywool@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Vitaly Wool <vitalywool@gmail.com>
