From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Aug 2018 19:06:30 +0200
Subject: [PATCH 1/5] meson_sm: add TEST_N pin direction call
In-Reply-To: <1533117848-28194-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117848-28194-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdbpe4RjCa6MnC=hvEEHJq8SAq5UAzuVKRU_rTxx_hRyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2018 at 12:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The Amlogic Meson GX and AXG has a Secure Monitor call to change the
> TEST_N pin gpio direction, add it in the supported call list.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Looks fine to me, could we have Carlo's review on this patch?

Yours,
Linus Walleij
