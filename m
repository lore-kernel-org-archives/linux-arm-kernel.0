From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 28 Oct 2012 20:02:48 +0100
Subject: [PATCH 1/2] pinctrl/: at91: fix warmings
In-Reply-To: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
References: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdbP98R4+dh2SL8EeZBe=7O_j3uqt6zarwTBTPq0pEV_8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 7:53 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> /opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c: In function 'at91_pinctrl_probe_dt':
> /opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c:952:12: warning: assignment discards qualifiers from pointer target type
> /opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c: In function 'at91_gpio_probe':
> /opt/work/linux-2.6/drivers/pinctrl/pinctrl-at91.c:1517:17: warning: assignment discards qualifiers from pointer target type
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Thanks, patch applied to my at91 branch.

Yours,
Linus Walleij
