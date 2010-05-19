From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 May 2010 14:37:19 -0600
Subject: [PATCH] SPI: add support for the PL023 derivate
In-Reply-To: <1273221653-15654-1-git-send-email-linus.walleij@stericsson.com>
References: <1273221653-15654-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTikhY9ooI-K5-apCygxSo8ejMUVjxh9FqmK2YhCD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 7, 2010 at 2:40 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This adds support for a further ST variant of the PL022 called
> PL023. Some differences in the control registers due to being
> stripped down to SPI mode only, and a new clock feedback sample
> delay config setting is available.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Note: Grant this one is supposed to be applied on top of the
> previous patch to fix up PL022 confusion, I can resend
> these as a condensed patch series if you like, just tell me.
>
> The stuff to be queued in Dan Williams tree for DMA support has
> been tested to be applied before and after this patch and apply
> cleanly so we don't have to worry about these patch sets
> colliding.

This one and the previous patch look okay to me.  I'll pick them up
(assuming no compile breakage).

g.
