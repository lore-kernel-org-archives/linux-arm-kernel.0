From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 12:42:34 +0200
Subject: [PATCH 4/4 v4] ARM: ks8695: convert to generic time and
 clocksource
In-Reply-To: <5045C0B2.6010509@snapgear.com>
References: <1346742590-10719-1-git-send-email-linus.walleij@linaro.org>
 <5045C0B2.6010509@snapgear.com>
Message-ID: <CACRpkdZmOO1AeKHBaX3kcxiwkVZgrJ=yaY+QfC3spOmixMx+iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2012 at 10:49 AM, Greg Ungerer <gerg@snapgear.com> wrote:

> Moving this outside the "if" below causes it to hang during boot.
> It hangs at "Calibrating delay loop...".
>
> Putting it back inside the "if" and it all works as expected.

Hm, I wonder why. Oh well, nevermind, I'll respin again...

Thanks for your patience!

Yours,
Linus Walleij
