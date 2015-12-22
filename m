From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 10:29:13 +0100
Subject: [PATCH resend] pinctrl: sunxi: Add A80 special pin controller
In-Reply-To: <1450283982-25295-1-git-send-email-wens@csie.org>
References: <1450283982-25295-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdYW3teBky_GvqLxUt7+Zr29k-CRKb7Lj=MKkcB-zSrC_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 5:39 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Like the previous designs, the A80 has a special pin controller for the
> critical pins, like the PMIC bus.
>
> Add a driver for this controller.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [wens: Add A80 compatible strings to bindings doc; fix pin function
>        names based on v1.3 datasheet; constify of_device_id table]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> Linus, can we have this one included for 4.5?

Yep. Patch rebased and applied!

Yours,
Linus Walleij
