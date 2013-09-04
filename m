From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Sep 2013 07:43:01 +0200
Subject: [PATCH V3 2/4] mmc: mmci: Use optional sleep pinctrl state
In-Reply-To: <1378200576-13413-3-git-send-email-ulf.hansson@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
 <1378200576-13413-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdYed8ZrGX+ADR51x+ctes1My2m=hJHV71WSrExZHPbeaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 3, 2013 at 11:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> By optionally putting the pins into sleep state in the .runtime_suspend
> callback we can accomplish two things. One is to minimize current leakage
> from pins and thus save power, second we can prevent the IP from driving
> pins output in an uncontrolled manner, which may happen if the power domain
> drops the domain regulator.
>
> When returning from idle, entering .runtime_resume callback, the pins
> are restored to default state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
