From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 13:03:09 +0200
Subject: [PATCH 2/6] pinctrl: sunxi: Move the pins definitions to a
 separate header
In-Reply-To: <1370795767-9769-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdajdrcLy6u2cKkrpYnh0Hqx8Hjx+zJ_tfpYCfJFqWCrZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 6:36 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> It will allow us to have a cleaner separation between the data needed by
> the driver to work, and the core logic of the driver in itself, and will
> allow having too much noise in the core driver in the future.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Since you will anyway have to bring the ARM SoC branch on
top of the pinctrl tree, I might as well apply this to my tree.

If everything else fails, you'll have a nice development base
in v3.11 with this in place, right?

Yours,
Linus Walleij
