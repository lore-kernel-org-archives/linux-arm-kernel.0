From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 14:55:52 +0200
Subject: [PATCH 4/4] dma: ste_dma40: Fixup system suspend/resume
In-Reply-To: <1398282724-2607-4-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
 <1398282724-2607-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZ=herUXtkDfsVD0xTNUG3f272eGw=o_nWpi-GyCsWJPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 9:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Make sure to handle register context save/restore when needed from
> system PM callbacks.
>
> Previously we solely trusted the device to reside in in-active state
> while the system suspend callback were invoked, which is just too
> optimistic.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
