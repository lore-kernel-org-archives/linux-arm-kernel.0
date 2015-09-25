From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Sep 2015 09:20:59 -0700
Subject: [PATCH] gpio: msm: Remove unused driver
In-Reply-To: <1440798536-8337-1-git-send-email-sboyd@codeaurora.org>
References: <1440798536-8337-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkda519TxyK9oKDR07m9oG1tUS-RbVLr4_rMBG18bvVyc2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 2:48 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Remove this driver now that Bjorn has introduced a pinctrl driver
> for msm8660 and the dts files have been updated with the pinctrl
> compatibles.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch rebased and applied, thanks!
This concludes the modernization of the MSM GPIO and
pin control, awesome!

Yours,
Linus Walleij
