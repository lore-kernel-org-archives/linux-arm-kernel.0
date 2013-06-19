From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 21:06:20 +0200
Subject: [PATCH 0/2] Fix build breakage for tnetv107x platforms
In-Reply-To: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
References: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
Message-ID: <CACRpkdaSTVgueBfvEt-C=f0tuem7BbuEdx-38HZPPJDGjtKELA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 11:57 AM, Philip Avinash
<avinashphilipk@gmail.com> wrote:

> tnetv107x_defconfig build failing on removal selection of NEED_MACH_GPIO_H
> for ARCH_DAVINCI. This is due to header files inclusion from mach/gpio-davinci.h
> So this patch series fixes the build breakage on removal of NEED_MACH_GPIO_H.
>
> This patch series is based on Linux 3.10-rc4 and is availabel at [1] and dependency on 2.
>
> 1. https://github.com/avinashphilip/am335x_linux/tree/linux_davinci_v3.10_soc_gpio_v310-rc4
> 2. https://patchwork.kernel.org/patch/97853/
>
> Philip Avinash (2):
>   ARM: davinci: fix for build breakage for tnetv107x platforms
>   gpio: gpio-tnetv107x: Fix bulid breakge

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
