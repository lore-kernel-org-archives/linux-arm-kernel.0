From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Sep 2012 22:14:02 +0200
Subject: [PATCH 1/1] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <1348474306-25155-1-git-send-email-lee.jones@linaro.org>
References: <1348474306-25155-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbmDtsb7cxWLeuBKyz0RYDX6uQjnm0uHd_ndY+NKdnHhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 10:11 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The PRCMU has its own USB, Thermal, GPIO, Modem, HSI and RTC drivers,
> amongst other things. This patch allows those subordinate devices to
> use it as an interrupt controller as and when they are DT enabled.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is good stuff.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sam, please pick this up, IRQdomains are a pathway to many
good things.

Yours,
Linus Walleij
