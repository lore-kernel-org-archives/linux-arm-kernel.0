From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 11:32:05 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Fix SPDIF function name for A83T
In-Reply-To: <20170522062552.19026-4-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-4-wens@csie.org>
Message-ID: <CACRpkdbjExYKgMCgNznaWHJBkufFR7WmisrFzKrP9bc0NudRhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 8:25 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> We use well known standard names for functions that have name, such as
> I2C, SPI, SPDIF, etc..
>
> Fix the function name of SPDIF, which was named OWA (One Wire Audio)
> based on Allwinner datasheets.
>
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller
>                       support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
