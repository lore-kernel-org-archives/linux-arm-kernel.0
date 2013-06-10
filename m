From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 15:44:37 +0200
Subject: [PATCH 1/4] pinctrl: sunxi: Search the description array by pin id
In-Reply-To: <1370685946-3718-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370685946-3718-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYpkXMS08+xKWUbY_7udYW6zWxXUpothHv0Kr26H91XJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 12:05 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Avoid to use expensive string manipulation functions and search by pin
> id when possible.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Very elegant. Patch applied.

Yours,
Linus Walleij
