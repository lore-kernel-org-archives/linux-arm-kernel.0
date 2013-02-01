From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Feb 2013 10:43:30 +0100
Subject: [PATCH 1/5] ARM: sunxi: Increase the number of GPIOs available
In-Reply-To: <1359211016-24097-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359211016-24097-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYwz113zmCBCYp8=oQ5QM8dw9sb=W7r0pe=+PeazbyOYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 3:36 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The Allwinner A10 has 9 banks of 32 GPIOs available, so it doesn't fit
> in the usual 256 limit set by gpio.h. Increase this number to 288.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied to the pinctrl tree on my allwinner branch,
with Arnd's ACK.

Yours,
Linus Walleij
