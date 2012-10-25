From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 16:41:43 +0200
Subject: [GIT PULL] ux500 fixes due for v3.7 RCs
In-Reply-To: <201210251352.31364.arnd@arndb.de>
References: <20121025094147.GA4008@gmail.com>
 <201210251352.31364.arnd@arndb.de>
Message-ID: <CACRpkdZM3wHh9jey1eUfw9yjRTMK_fW5nKf1HcQuf2aExpPxbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 3:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Since we're now getting pull requests from both of you, Lee and Linus,
> I'd like to understand how you are organized.
>
> Lee, are you just sending bug fixes directly and send future work through
> Linus, or are you acting as backup maintainer when he is busy otherwise
> in general?

Let us say that Lee is pushing stuff that is DT-related, e.g. fixes that
only manifest in DT environments and I'm pushing most other stuff.

I'm happy that Lee is doing some nice offloading as pinctrl and gpio is
currently quite busy.

One day Srinidhi may also send pull requests, as co-maintainer.

Yours,
Linus Walleij
