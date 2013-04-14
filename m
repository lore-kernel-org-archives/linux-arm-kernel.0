From: marex@denx.de (Marek Vasut)
Date: Sun, 14 Apr 2013 20:40:47 +0200
Subject: [PATCH v2] UCB1400: Pass ucb1400-gpio data through ac97 bus
In-Reply-To: <1365964548-4193-1-git-send-email-marex@denx.de>
References: <CACRpkdZ+ku_-SBTXwwwRDh7F2TXzpgpAF3k+Ksn98BNYXximXw@mail.gmail.com>
 <1365964548-4193-1-git-send-email-marex@denx.de>
Message-ID: <201304142040.48132.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  drivers/gpio/gpio-ucb1400.c |   19 ++++++-------------
>  drivers/mfd/ucb1400_core.c  |    5 +++++
>  include/linux/ucb1400.h     |   18 ++++++------------
>  3 files changed, 17 insertions(+), 25 deletions(-)
> 
> v2: Rebase patch from:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/028656.h
> tml
> 
> NOTE: I didn't even compile-test this, but the fix was plenty
> straightforward.

But damn, this code is ugly. I'm retrospectively-ashamed.

Best regards,
Marek Vasut
