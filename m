From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 03:50:51 +0200
Subject: [PATCH 6/9] ARM: SPMP8000: Add pwm driver
In-Reply-To: <1318178172-7965-7-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-7-git-send-email-zoss@devai.org>
Message-ID: <CAKnu2MocUpNwK5n3sq=5+n0vZEO-JRz+PAJQtE7yX3ZQ8-wq1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
> ?arch/arm/mach-spmp8000/pwm.c | ?246 ++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 246 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-spmp8000/pwm.c

Also PWM should have its own subsystem, sadly that is an area
where discussions about the patches for generic PWM in
drivers/pwm/ by Sascha Hauer seem to have stalled recently. :-(

Those we have tend to live in drivers/misc/ and drivers/mfd/
which is not good.

Kudos to Sascha for trying to solve the mess, we need more
subsystems...

Yours,
Linus Walleij
