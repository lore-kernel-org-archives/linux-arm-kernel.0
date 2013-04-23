From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Apr 2013 14:00:11 +0200
Subject: [PATCH 1/2] pinctrl: s3c64xx: Fix build error caused by undefined
 chained_irq_enter
In-Reply-To: <30362001.FF4K7WsZvh@flatron>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <20130416163331.GP26958@opensource.wolfsonmicro.com>
 <30362001.FF4K7WsZvh@flatron>
Message-ID: <CACRpkdZ_9K-=4C7ksScqoX3WeF0LyPrzkCS6iMG6u_mCNnWRWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 12:23 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Commit de88cbb7 moved definitions of chained_irq_enter and
> chained_irq_exit to a generic header, which must be now included instead
> of the legacy arch-specific one.
>
> This patch fixes build error caused by including the legacy header
> leading to undefined chained_irq_enter and chained_irq_exit symbols.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied.

Thanks!
Linus Walleij
