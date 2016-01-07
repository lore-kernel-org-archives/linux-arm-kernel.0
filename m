From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Jan 2016 10:37:27 +0100
Subject: [PATCH 3/3] Revert "pinctrl: qcom: make PMIC drivers bool"
In-Reply-To: <1452129169-2014-4-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
 <1452129169-2014-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdaH04c64xh-0-PR_YRB3DGLktXdzMq_JDnO8NYnxwa=gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 2:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> This reverts commit bda7c4c2b9767ce2af4394754498662d62079af5.
> These drivers build as modules now that we use
> platform_irq_count() instead of of_irq_count().
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch applied.

Thanks for digging in and fixing this, excellent work as always.

Yours,
Linus Walleij
