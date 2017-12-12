From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Dec 2017 00:53:24 +0100
Subject: [PATCH] pinctrl: meson-axg: adjust spicc pin naming
In-Reply-To: <20171208152909.15632-1-yixun.lan@amlogic.com>
References: <20171208152909.15632-1-yixun.lan@amlogic.com>
Message-ID: <CACRpkdYnQDsy7T+Tdj_ALic=x3pUReAEyCYDE7f+trkSABDzBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 4:29 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> According to datasheet, we should use numbers for the pin naming
> instead of letters. The patch here try to fix this to keep
> the consistency.
>
> This patch should not bring any functional change.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Suggested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied.

Yours,
Linus Walleij
