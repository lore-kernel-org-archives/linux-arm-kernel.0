From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Jul 2013 22:54:42 +0200
Subject: [PATCH 0/3] MSM gpio fixes
In-Reply-To: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
References: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
Message-ID: <CACRpkdbOO8fFEx+PxsdJ9F1dqD6V4_RPZThvTufo9+XhhyuHOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:07 PM, David Brown <davidb@codeaurora.org> wrote:

> Rohit sent these three fixes out on June 18.  I still need a
> devicetree ack for the first patch, and would like these to get pulled
> in for v3.11
>
> Rohit Vaswani (3):
>   ARM: msm: dts: Fix the gpio register address for msm8960
>   drivers: gpio: msm: Fix the error condition for reading ngpio

OK for these two...

>   ARM: msm: Consolidate gpiomux for older architectures

This does not look like a fix? Surely this can wait for v3.12?

Yours,
Linus Walleij
