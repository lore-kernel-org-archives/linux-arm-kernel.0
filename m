From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Mar 2011 12:46:47 +0100
Subject: [PATCH] mmci: separate out ST Micro register defines
In-Reply-To: <1299228173-3162-1-git-send-email-linus.walleij@stericsson.com>
References: <1299228173-3162-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTi=HYjSHQgZLK8xbCgMNjmeKw7_Ok1pC0TAqWJ0R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell:

On Fri, Mar 4, 2011 at 9:42 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> The mmci.h header contained a few registers not clearly marked
> as ST Micro only, rectify this and remove the HWFC magic in the
> process. The idea is to make the mmci.h header file more ordered
> so other vendors with PL180 derivates can see where to put in
> their custom register defines.

This is marked as "applied" in the patch tracker, since it's not
in mainline merges or next, just checking that it didn't get lost due
to harddisk problems or such?

Yours,
Linus Walleij
