From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 10:40:04 +0200
Subject: [PATCH 3/6] pinctrl: mediatek: constify gpio_chip structures
In-Reply-To: <1473596082-32690-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
 <1473596082-32690-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZD2QD50B785M5a8LpoaJuwBjmn-yo0tmwJaMVj2Et39A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 2:14 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> These structures are only used to copy into other structures, so declare
> them as const.
(...)
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied.

Yours,
Linus Walleij
