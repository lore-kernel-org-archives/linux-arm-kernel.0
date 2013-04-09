From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 09:37:40 +0200
Subject: [PATCH 1/6] pinctrl: samsung: Protect bank registers with a
 spinlock
In-Reply-To: <1363642315-10331-2-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
 <1363642315-10331-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdb9JUzTtxQa++jVJHCPM_ZaWUnO1pfi9=7oNpMuGnc+LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:31 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Certain pin control registers can be accessed from different contexts,
> i.e. pinctrl, gpio and irq functions. This makes the locking provided by
> pin control core insufficient.
>
> This patch adds necessary locking using a per bank spinlock as it was
> done in the old Samsung GPIO driver.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

OK no reaction from the other Samsung maintainers so now I start
applying these...

Patch applied!

Yours,
Linus Walleij
