From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 13:35:23 +0200
Subject: [PATCH] ARM: ux500: Fix initialisation order for UIBs
In-Reply-To: <1348585812-32073-1-git-send-email-lee.jones@linaro.org>
References: <1348585812-32073-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYJZO8m1xHYS2DHYk3sbeoG4izTyLk6rP96AqX9hM=z8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 5:10 PM, Lee Jones <lee.jones@linaro.org> wrote:

> An earlier change prevented User Interface Boards (UIBs) from being
> initialised on boards which did not support them. This change had
> the undesired effect of reordering the UIB initialisation calls with
> I2C registration. Here we ensure UIBs are only setup after all
> required infrastructure is already in place.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
