From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 May 2014 10:33:26 +0200
Subject: [PATCH] RFT: pinctrl: msm: switch to using generic GPIO irqchip
 helpers
In-Reply-To: <1398794794-28920-1-git-send-email-linus.walleij@linaro.org>
References: <1398794794-28920-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdb7ctDocntcPG_E4b_an2G8VNd+ei0N+Uk_7XtsFssiEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 8:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This switches the Qualcomm MSM pin control driver over to using
> the generic GPIO irqchip helpers.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Josh Cartwright <joshc@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Anyone up for testing this patch?

Bj?rn? Andy?

Or shall I just push it to linux-next and see what happens?

Yours,
Linus Walleij
