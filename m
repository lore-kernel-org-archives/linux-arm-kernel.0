From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 18:20:13 +0200
Subject: [PATCH 07/10] pinctrl: sunxi: Add Allwinner A31 pins set
In-Reply-To: <1374618312-19001-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZ1RhsLMC0xWDDr9Hmy78i+uU-9x0-2Y+_NvRZ-yefmVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 12:25 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The Allwinner A31 SoC uses the same IP than the one found in the
> A10/A13, with only different pins. Add the pins and the associated
> functions found in the A31.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you carry this through ARM SoC or do you want me to merge
this into the pinctrl tree? It seems pretty independent.

Yours,
Linus Walleij
