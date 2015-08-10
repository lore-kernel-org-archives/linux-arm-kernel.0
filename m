From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 12:02:13 +0200
Subject: [PATCH 6/6] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <1438680203-13432-7-git-send-email-mpa@pengutronix.de>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-7-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdajd5B6qUa6mi_0m53eMtLenoAWUCnmq-mOC+EhXfzpTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Add some information about gpio names to the debugfs gpio file. name and
> label of a GPIO are then displayed next to each other. This way it is
> easy to see what the real name of GPIO is and what the driver requested
> it for.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

This patch looks correct in the context.

Yours,
Linus Walleij
