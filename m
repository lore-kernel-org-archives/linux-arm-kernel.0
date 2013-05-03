From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 15:41:14 +0200
Subject: [PATCH 2/4 v2] mfd: ab8500-gpadc: Suppress 'ignoring
 regulator_enable() return value' warning
In-Reply-To: <20130503111537.GH24153@gmail.com>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-3-git-send-email-lee.jones@linaro.org>
 <20130503111537.GH24153@gmail.com>
Message-ID: <CACRpkdZUDFakgYbUsbm6y9G0TqNr2z8U-f3Y1T6vNR1+CvLpKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 1:15 PM, Lee Jones <lee.jones@linaro.org> wrote:

> drivers/mfd/ab8500-gpadc.c: In function ?ab8500_gpadc_resume?:
> drivers/mfd/ab8500-gpadc.c:911:18: warning: ignoring return value of
>         ?regulator_enable?, declared with attribute warn_unused_result
>         [-Wunused-result]
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
