From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2017 10:57:03 +0100
Subject: [PATCH 1/2] pinctrl: sunxi: Support A31/A31s with pinctrl variants
In-Reply-To: <20170201162547.24232-2-wens@csie.org>
References: <20170201162547.24232-1-wens@csie.org>
 <20170201162547.24232-2-wens@csie.org>
Message-ID: <CACRpkdZfiwPzqH5BGi77WB_890_=P77=saQovwV1hM4X8wW9qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 5:25 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The A31s is a trimmed down version of the A31. Some hardware blocks
> are removed, thus not available for muxing on the external pins.
> Some external pins were directly removed.
>
> This makes it easy to support the A31s pin controller with the A31
> driver. We just mark the pins and functions that were trimmed as
> A31 only.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied.

Yours,
Linus Walleij
