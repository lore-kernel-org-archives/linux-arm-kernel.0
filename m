From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 11:21:21 +0200
Subject: [PATCH 2/3] pinctrl: sunxi: Add support for A83T R_PIO
In-Reply-To: <20170603144427.22855-3-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
 <20170603144427.22855-3-wens@csie.org>
Message-ID: <CACRpkdY6bXSP3pqD03VXenGM1YzQ-pBKnwcYou+oHGpXLGXG5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 3, 2017 at 4:44 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The R_PIO on the A83T is almost the same as the one found on the A64,
> except that the CIR_RX function was moved from pin PL11 to pin PL12.
>
> Add a driver for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied.

Yours,
Linus Walleij
