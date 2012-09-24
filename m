From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Sep 2012 21:55:51 +0200
Subject: [PATCH] gpio-lpc32xx: Fix value handling of
 gpio_direction_output()
In-Reply-To: <1348130883-11329-1-git-send-email-stigge@antcom.de>
References: <1348130883-11329-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdZo5kR+Tyhos_StEFZbw3WHF_RFRknHjtU2Pz4XpFTZCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:48 AM, Roland Stigge <stigge@antcom.de> wrote:

> For GPIOs of gpio-lpc32xx, gpio_direction_output() ignores the value argument
> (initial value of output). This patch fixes this by setting the level
> accordingly.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied with Alexandre's ACK, should go into stable right?
So tagging this with Cc: stable and sending for the -rc:s.

Thanks,
Linus Walleij
