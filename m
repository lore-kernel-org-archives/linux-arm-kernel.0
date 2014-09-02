From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Sep 2014 14:36:12 +0200
Subject: [PATCH v3 4/4] pinctrl: qcom: Add support for reset for apq8064
In-Reply-To: <1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>
 <1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <CACRpkdbnkgb2YOKAPTFSaDhj7OMbfF+14_PeDch5mFLwjOANEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 4:30 PM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:

> This patch adds support for reset functions to reboot the boards
> with soc apq8064.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> CC: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> CC: Stephen Boyd <sboyd@codeaurora.org>
> CC: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

OK patch applied with Bj?rn's ACK.

A bit dirty to have this in this driver, but who cares.

Does the APQ8064 accompanying PMIC also have the ability to
completely shut the system down?

Yours,
Linus Walleij
