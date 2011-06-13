From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2011 10:16:01 +0200
Subject: [PATCH] mach-ux500: iomap PRCMU TCDM memory
In-Reply-To: <1307613035-1633-1-git-send-email-mattias.wallin@stericsson.com>
References: <1307613035-1633-1-git-send-email-mattias.wallin@stericsson.com>
Message-ID: <BANLkTikHwORWqUChqE7RJUKr+9rCPz-USw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2011 at 11:50 AM, Mattias Wallin
<mattias.wallin@stericsson.com> wrote:

> The PRCMU TCDM memory needs to be iomapped for the PRCMU to work
> properly.
>
> Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've picked this into the ux500-core branch for further passing to the
arch maintainer tree.

Thanks,
Linus Walleij
