From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Mar 2018 03:44:38 +0100
Subject: [PATCH v2] pinctrl: sunxi: always look for apb block
In-Reply-To: <20180303122554.20984-1-andre.przywara@arm.com>
References: <20180303122554.20984-1-andre.przywara@arm.com>
Message-ID: <CACRpkdaCkE_hAyLm+XM2mGKrOe5iFO2gM9eTXbMVAqFKPgB6Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 3, 2018 at 1:25 PM, Andre Przywara <andre.przywara@arm.com> wrote:

> The Allwinner pinctrl device tree binding suggests that a clock named
> "apb" would drive the pin controller IP. However (for legacy reasons) we
> rely on this clock actually being the first clock defined.
> Since named clocks can be in any order, let's explicitly check for a
> clock called "apb" if there is more than one clock referenced.
>
> Kudo to Maxime for suggesting this much more elegant approach.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
