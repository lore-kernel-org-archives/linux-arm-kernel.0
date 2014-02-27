From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Feb 2014 10:18:12 +0100
Subject: [PATCH] gpio: msm: switch Kconfig to ARCH_QCOM depends
In-Reply-To: <1392150132-21877-1-git-send-email-galak@codeaurora.org>
References: <1392150132-21877-1-git-send-email-galak@codeaurora.org>
Message-ID: <CACRpkdZhsezPJd5q3ec7qh_6c+hQjQpi8iRiZHB2yT1T9bjPew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 9:22 PM, Kumar Gala <galak@codeaurora.org> wrote:

> We've split Qualcomm MSM support into legacy and multiplatform.  The gpio
> msm-v2 driver is only relevant on the multiplatform supported SoCs so
> switch the Kconfig depends to ARCH_QCOM.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> Linus,
>
> If you can ack this I'll send it via linux-qcom/arm-soc tree's

Yeah:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

It took some time because your repeated pings bring the message
to the top of my mailbox and I process it from the bottom...

Yours,
Linus Walleij
