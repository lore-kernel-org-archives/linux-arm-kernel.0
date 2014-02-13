From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Feb 2014 13:55:19 +0100
Subject: [PATCH 3/7] Documentation: devicetree: fix up pl022 clocks
In-Reply-To: <1392118632-11312-4-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1392118632-11312-4-git-send-email-mark.rutland@arm.com>
Message-ID: <CACRpkdbPbRkTEJQQ3tjS_OFPF9TKY6HOFe-zTxAqeJ7nxA1H1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 12:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> Currently the pl022 driver expects clocks, and dts provide them, yet the
> binding does not mention clocks at all.
>
> This patch adds a description of the clocks, "apb_pclk" (as required by
> the primecell binding) and "sspclk" for the pl022 itself. The "sspclk"
> name was chosen to match the official documentation, as currently a
> variety of names are used in its place; it is expected that any
> operating system supporting these can continue to do so in the absence
> of an "sspclk" entry.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
