From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Jun 2012 18:30:10 +0200
Subject: [PATCH 2/9] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <1339324322-29388-3-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-3-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdY+egHAMxwLVOfRPYykeB3=nS=hVmdMDK0Q_6U9PZYbZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Looks good to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
