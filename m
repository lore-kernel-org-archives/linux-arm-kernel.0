From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 09:37:06 +0100
Subject: [PATCH V4 0/4] DRIVERS: IRQCHIP: Add support for crossbar IP
In-Reply-To: <1384431530-2166-1-git-send-email-r.sricharan@ti.com>
References: <1384431530-2166-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CACRpkdYM1XcBAznCpmPU+j2kHFPKYA98OAYrpLhcSJr4KbRZzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 1:18 PM, Sricharan R <r.sricharan@ti.com> wrote:

> The minimal crossbar driver to track and allocate free GIC lines and configure the
> crossbar is added here, along with the DT bindings.
>
> V4:
>    Addressed a couple of comments and split the DTS file updates in to
>    a separate series.

I'm pretty happy with the work and effort put into this now it's looking
real elegant.
FWIW: Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
