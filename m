From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 May 2015 17:30:16 +0200
Subject: [PATCH 3/6] gpio: add lpc18xx gpio driver
In-Reply-To: <1428095767-6286-4-git-send-email-manabian@gmail.com>
References: <1428095767-6286-1-git-send-email-manabian@gmail.com>
 <1428095767-6286-4-git-send-email-manabian@gmail.com>
Message-ID: <CACRpkdZa0TeeCagyOOQwsKVLQ6-Ab99wzEznwGV7x8y7YNr=BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 3, 2015 at 11:16 PM, Joachim Eastwood <manabian@gmail.com> wrote:

> Driver for the GPIO block found on NXP LPC18xx/43xx devices.
>
> The GPIO block is divided into 8 ports which each support up
> to 32 gpios. The which gpios that are available depends on the
> specific device and it's package.
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

Patch applied. Needed some rebasing but whatever.

Yours,
Linus Walleij
