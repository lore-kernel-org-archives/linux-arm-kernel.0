From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 21:35:17 +0200
Subject: [PATCH] ARM: ux500: update MSP1 pinctrl defintions
In-Reply-To: <1368004193-21213-1-git-send-email-fabio.baltieri@linaro.org>
References: <1368004193-21213-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdZj6r3=fo=72PDshHbL7oHxb6H6uGeGvRyb2+uMjoAvUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 11:09 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Update MSP1 pinctrl definitions in mop500_family_pinmap by removing
> sleep state and setting default ones as pin hogs, as those are used by
> both ux500-msp-i2s.1 and ux500-msp-i2s.3.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Applied to my ux500-pinctrl branch.

I need to refresh the entire pinctrl setup anyway, so will make
big changes in this file, and need to keep it in my tree.

Yours,
Linus Walleij
