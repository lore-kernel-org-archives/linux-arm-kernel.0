From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Sep 2014 09:36:03 +0200
Subject: [PATCH v2 3/3] pinctrl: at91: update documentation for drive
 strength options and tweaks
In-Reply-To: <1408849926-9603-3-git-send-email-mark.roszko@gmail.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
 <1408849926-9603-3-git-send-email-mark.roszko@gmail.com>
Message-ID: <CACRpkdYMpW-hML=aJzyB3ze_ibqjYu2KX0iQmjUO5dfx2mG3xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 5:12 AM, Marek Roszko <mark.roszko@gmail.com> wrote:

> The drive strength patched introduced the atmel,sama5d-pinctrl compatible string.
> Drive strength is now an option for the CONFIG bits per pin. Also added note about
> MULTIDRIVE being equivalent to open-drain output and added missing "s" at the
> end of need everywhere in the bits descriptions.
>
> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>

Also tentatively applied.

Yours,
Linus Walleij
