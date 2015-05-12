From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 May 2015 13:18:11 +0200
Subject: [PATCH] pinctrl: lpc18xx: create pin cap lookup helper
In-Reply-To: <1430932281-3432-1-git-send-email-manabian@gmail.com>
References: <1430932281-3432-1-git-send-email-manabian@gmail.com>
Message-ID: <CACRpkdY-_+Y3UqoSM7BHTukbwtRfi9w5Sf00NQsRQuPxXgr_gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 7:11 PM, Joachim Eastwood <manabian@gmail.com> wrote:

> Both pconf_get_pin and pconf_set_pin needs to lookup pin cap based
> on the pin number. Create a common helper function that both
> functions can use that also handles the case where no pin number is
> found in the pins array.
>
> This also fixes a small bug in pconf_get_pin where pconf_get_i2c0
> would use the pins array index rather than the pin number.
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi Linus,
>
> Patch is based on your linux-pinctrl devel branch.
> Since it's a new driver feel free to squash it with the initial commit.

Patch applied, removed the other hackish check.

Yours,
Linus Walleij
