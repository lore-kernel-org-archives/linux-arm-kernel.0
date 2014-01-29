From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jan 2014 15:26:03 +0100
Subject: [PATCH] ARM: iop32x: fix reset handling for the EM7210 board
In-Reply-To: <1390999545-31428-1-git-send-email-linus.walleij@linaro.org>
References: <1390999545-31428-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201401291526.03779.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 January 2014, Linus Walleij wrote:
> This board was missed when converting all the others to proper
> abstracted GPIO handling. Fix it up the right way by requesting
> and driving GPIO line 0 high through gpiolib to reset the machine.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the prompt resolution. Aside from what Arnaud mentioned,

Acked-by: Arnd Bergmann <arnd@arndb.de>
