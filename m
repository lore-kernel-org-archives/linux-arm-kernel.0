From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 09:52:03 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
Message-ID: <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 3:37 PM, Houcheng Lin <houcheng@gmail.com> wrote:

> The Problem
> -----------
> The reset signal on a hardware board is send either:
>     - during machine initialization
>     - during bus master's initialization

I just thought about this a bit, since there isn't already a generic GPIO
reset driver, just call this drivers/reset/reset-gpio.c and make the
ability to deferral just a configuration detail of the GPIO reset driver.

Yours,
Linus Walleij
