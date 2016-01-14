From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jan 2016 09:52:56 +0100
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Skip pullup on ULT type MPPs
In-Reply-To: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
References: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdbbS+tJOMQ=EikW+9DKtk_2JoEcOz7KRTTA=+ibrD=gLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2016 at 9:25 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The ULT type of MPPs don't have a pullup. Skip configuring the
> pullup on these types of pins.
>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

I take it that this is not a regression so it will have to wait until
kernel v4.6 at this point. I will queue new patches after the merge
window, if I forget it please remind me.

Yours,
Linus Walleij
