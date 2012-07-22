From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jul 2012 09:22:09 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <1342805751-18048-3-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 7:35 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Send these with Mark Brown on the To: line right now, I think he's
busy collecting SPI patches for the next merge window.

Yours,
Linus Walleij
