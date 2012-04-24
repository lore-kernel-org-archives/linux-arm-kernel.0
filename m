From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 10:05:36 +0200
Subject: [PATCH 11/15] ARM: ux500: Do not attempt to register non-existent
 i2c devices on Snowball
In-Reply-To: <1334867804-31942-12-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbeeEogAy+9kvprZiKy-A-mP8gNsFbcwXS6fto2zBP_YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch prevents i2c devices which are not present on the Snowball
> low-cost development board from being registered. Devices such as;
> tc3589x, bu1780 and lp5521 are present on other supported boards,
> but are not located on Snowball.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Oh, this looks like an important fix. I've rebased it and applied it to
my ux500-core branch with some small fixup.

Thanks,
Linus Walleij
