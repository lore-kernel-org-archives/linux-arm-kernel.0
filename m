From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 08:27:52 +0200
Subject: [PATCH 0/6] crypto: ux500/[cryp|hash] - Enable Device Tree
In-Reply-To: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdapJ4Y0fxHa_j0WaOtWEom3y+bv2aA3qVBnLBjHsB2tOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 1:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch-set simply allows ux500-[cryp|hash] drivers to be probed
> when Snowball is running with Device Tree enabled.
>
> Linus,
>
> Feel free to split the DTS changes out into your ux500-devicetree branch.

I have tentatively applied 1, 2, 3 & 4 to my device tree branch.

5 & 6 need bindings and ACKs.

I can merge them through the ux500 devicetree branch as well I
think, they "should" be orthogonal to other (DMA-related) changes
AFAICT.

Yours,
Linus Walleij
