From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 14:49:34 +0200
Subject: [PATCH] pinctrl: sunxi: Remove PINCTRL_SUNXI
In-Reply-To: <1404050299-27895-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404050299-27895-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkda+V3317bnw9ezZtkktb8gALg_OyJ-SW034oYK9FthW-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 3:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The PINCTRL_SUNXI configuration was kept only to deal with the introduction of
> per-machine symbols and the various pintrl drivers through different tree.
>
> Now that it's not useful anymore, we can just remove it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
