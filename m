From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Oct 2012 00:41:35 +0100
Subject: [PATCH] mvebu-gpio: Disable blinking when enabling a GPIO for
 output
In-Reply-To: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
References: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
Message-ID: <CACRpkdZ_4ZDKWf1-Mk=f282Z-zMrCHb_c67e_ijBUcocMM6Hjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 1:23 PM, Jamie Lentin <jm@lentin.co.uk> wrote:

> The plat-orion GPIO driver would disable any pin blinking whenever
> using a pin for output. Do the same here, as a blinking LED will
> continue to blink regardless of what the GPIO pin level is.
>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

OK applied to my fixes branch with Thomas' ACK.

Yours,
Linus Walleij
