From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2018 13:47:51 +0200
Subject: [PATCH] pinctrl: lpc18xx: mark expected switch fall-throughs
In-Reply-To: <20180815171035.GA17360@embeddedor.com>
References: <20180815171035.GA17360@embeddedor.com>
Message-ID: <CACRpkdYLWLhw-O00=Gc3FeVWt9dKFURNO2m5ic4MyjbJrGtGdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 7:10 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")
> Addresses-Coverity-ID: 1309546 ("Missing break in switch")
> Addresses-Coverity-ID: 1357369 ("Missing break in switch")
> Addresses-Coverity-ID: 1357389 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
