From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 01:50:10 -0700
Subject: [PATCH 03/19] ARM: ux500: Pass SDI DMA information though
 AUX_DATA to MMCI
In-Reply-To: <1347016499-29354-4-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda2dYTtXjgaoY1ujWLkx+iG6SdJkz=jPPcKU=bHkP_Y=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> There are four SDIs on the HREF, as opposed to the original two
> enabled on Snowball. To get them working we have to pass their DMA
> information in the same was as we need with the other two.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Yeah this will all go away once we get our precious DMA DT
bindings.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
