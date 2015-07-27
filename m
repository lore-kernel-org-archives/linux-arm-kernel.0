From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 13:59:20 +0200
Subject: [PATCH 1/4] pinctrl: sunxi: Use common functions to change
 irq_chip and handler
In-Reply-To: <1437396074-15791-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437396074-15791-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYNzuSs6+J1a8tzR56ERJCOuq4xVYZH=T2DS892L+kOKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 2:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current code uses some custom variable affectations, while we have
> common functions to do exactly that. Move to the common functions.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
