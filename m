From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 15:07:10 +0100
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Skip pullup on ULT type MPPs
In-Reply-To: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
References: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdY-X3QsQcoDJdLbZCK6keYXWS8GYo47Zu1vY4btAMdU0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2016 at 9:25 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The ULT type of MPPs don't have a pullup. Skip configuring the
> pullup on these types of pins.
>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch applied with Andy's review tag.

Yours,
Linus Walleij
