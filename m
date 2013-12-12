From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 21:39:34 +0100
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <1386787041-6035-4-git-send-email-syin@broadcom.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-4-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 7:37 PM, Sherman Yin <syin@broadcom.com> wrote:

> Adds a string to the PINCTRL config option so that 1) CONFIG_PINCTRL=y would
> not be erased by make config, and 2) PINCTRL option would show up in menuconfig.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> ---
> v3: added to patchset

NAK. The pin control subsystem has been designed so that
you should select the pin controller through select statements
from the SoC using it.

This was requested at one time by Linus (Torvalds).

You need to convince me that this is really needed.

Yours,
Linus Walleij
