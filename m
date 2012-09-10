From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 04:12:23 -0700
Subject: [PATCH 10/19] ARM: ux500: Remove redundant #gpio-cell properties
 from HREF and Snowball DT
In-Reply-To: <1347016499-29354-11-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY_gyWRO20ZOfTmG=tzE_B3ObWZG_4f8gHS6vyiGZSh6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> These properties have no place here as the populated nodes are
> not related to GPIO Controllers.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Squash this into the previous patch adding them...
I think Arnd already noted.

Yours,
Linus Walleij
