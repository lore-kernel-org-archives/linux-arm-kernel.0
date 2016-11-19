From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 19 Nov 2016 16:28:08 +0100
Subject: [GIT PULL] Allwinner late DT changes for 4.10
In-Reply-To: <20161119002733.GA15902@localhost>
References: <20161115210034.mwqnsggmmbzoav77@lukather>
 <20161119002733.GA15902@localhost>
Message-ID: <CACRpkdbw3AUj510wPGFG55cKnOyEOX7Syz1BnJx-ygo1eAqzGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 1:27 AM, Olof Johansson <olof@lixom.net> wrote:

> Also, this won't work since this branch does not contain the required
> pinctrl changes. If we merge this without basing it on those changes we lose
> bisectability.

I usually operate on the assumption that arch/*/boot/dts/* and drivers/*
do not need to be boot-time bisectable sync:ed, because of the ambition
to maintaining DTS files outside of the kernel in the long run, and at that
point they would be versioned orthogonally anyways.

On the other hand, that does look like a pipe dream, so maybe I should
just stop pretending.

Yours,
Linus Walleij
