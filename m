From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:47:13 +0100
Subject: [PATCH v2 3/4] pinctrl: sunxi: Add Allwinner A20 clock output pin
 functions
In-Reply-To: <1388373949-28506-4-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
 <1388373949-28506-4-git-send-email-wens@csie.org>
Message-ID: <CACRpkdaS+h1H2w_eJqy3tg8bxiNLpVWkij++Q8xUnN=CwbNKCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 4:25 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> This patch adds the clock output pin functions on the A20.
> The 2 pins can output a configurable clock to be used by
> external modules. This is used on the CubieTruck, to supply
> a 32768 Hz low power clock to the onboard Wifi+BT module.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
