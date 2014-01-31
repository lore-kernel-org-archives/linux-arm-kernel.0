From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 30 Jan 2014 22:11:27 -0800
Subject: [PATCH v2] ARM: iop32x: fix power off handling for the EM7210
 board
In-Reply-To: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Wed, 29 Jan 2014 15:20:15 +0100")
References: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <8761p0vfxs.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This board was missed when converting all the others to proper
> abstracted GPIO handling. Fix it up the right way by requesting
> and driving GPIO line 0 high through gpiolib to power off the
> machine.
>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Queueing for fixes (w/ack from Arnd.)

Kevin
