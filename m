From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 12:08:26 +0100
Subject: [PATCH v2 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <1352821485-10032-2-git-send-email-andrew@lunn.ch>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
 <1352821485-10032-2-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdYt5L_JhHHKg1b8Ghj0KAHT8dkP4etcnY+LjZw_BS9riw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 4:44 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> From: Jamie Lentin <jm@lentin.co.uk>
>
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low to power down
> your board.
>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

This looks good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
