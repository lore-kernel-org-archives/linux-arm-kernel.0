From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Jul 2014 09:35:11 +0200
Subject: [PATCH 6/6] pinctrl: samsung: Allow pin value to be initialized
 using pinfunc
In-Reply-To: <1404315664-3174-7-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-7-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdbZXNCHWOK0J2BCKoZN723FwosZQEa2wQHW4KpqX9EvrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:41 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch extends the range of settings configurable via pinfunc API
> to cover pin value as well. This allows configuration of default values
> of pins, which is useful for pins that are not supposed to be used by
> any dedicated driver, but need certain board-specific setting.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Patch applied. It always makes me a little bit sad that we didn't get
generic pin config in place before this driver but now we have to live
with it.

Yours,
Linus Walleij
