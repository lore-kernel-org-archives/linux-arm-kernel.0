From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 10:02:09 +0100
Subject: [PATCH] pinctrl: qcom: pmic-gpio/mpp: of_irq_count() == npins
In-Reply-To: <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
 <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdYJwW-5hg-d0Q+CUAB6vNXiPzSSk9fR-mE_ZD6enZUiEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 8:33 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The number of interrupts is always equal to the number of pins
> provided by the PMIC gpio and MPP hardware blocks. Count the
> number of irqs to figure out the number of pins instead of adding
> more compatible strings or doing math on the reg property. This
> should make the code more generic and ease the number of changes
> we have to make to the driver for each new pmic revision.
>
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch applied with Andy's and Bj?rn's ACKs.

Yours,
Linus Walleij
