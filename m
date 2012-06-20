From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 20 Jun 2012 21:10:15 +0530
Subject: [PATCH v2] pinctrl/coh901: use clk_prepare_[en|dis]able()
In-Reply-To: <1340181732-21953-1-git-send-email-linus.walleij@stericsson.com>
References: <1340181732-21953-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CADTbHxpyOqwx-VqmW5FGS9Qh2YUtsLRHyqXf7snSwS4JWLjnLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 2:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The COH901 GPIO driver did not prepare or unprepare its
> clock, so let us fix it to do so.
>
> Cc: Pankaj Jangra <jangra.pankaj9@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix up to use clk_disable_unprepare() on error and exit paths,
> ?noticed by Pankaj Jangra.
> ---
> ?drivers/pinctrl/pinctrl-coh901.c | ? ?6 +++---
> ?1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
