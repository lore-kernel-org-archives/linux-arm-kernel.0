From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 20:39:31 +0200
Subject: [PATCH v5 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <1377728173-30711-2-git-send-email-markus.mayer@linaro.org>
References: <1377728173-30711-1-git-send-email-markus.mayer@linaro.org>
 <1377728173-30711-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdYA82K7dOOi666mjapV81gcnQuo85jneyhLvct_XeP=yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 12:16 AM, Markus Mayer <markus.mayer@linaro.org> wrote:

> From: Markus Mayer <mmayer@broadcom.com>
>
> This patch adds the GPIO driver for the bcm281xx family of chips.

Be more elaborate. What is this? Where is it used, how many
lines does it support?

Plus the Subject: should be gpio: kona: add the kona driver
or something, not ARM: ... as it's hitting the GPIO
subsystem.

Yours,
Linus Walleij
