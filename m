From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Mar 2016 10:55:39 +0200
Subject: [PATCH v3 12/18] dt-bindings: Add PLX Technology OXNAS pinctrl
 and gpio bindings
In-Reply-To: <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdYvWKMFkng_rA364dDrM3-GoXrBnaEfT+mWR61ySMpPQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 5:50 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add pinctrl and gpio DT bindings for PLX Technology OXNAS SoC Family.
> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
(...)
> + - plxtech,gpio-bank: Specifies which bank a controller owns.

Rob commented on this too.

Other drivers just use "gpio-bank" for this, so use that.

I should add it to the generic bindings document.

Yours,
Linus Walleij
