From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Mar 2014 09:28:40 +0800
Subject: [PATCH] devicetree: bindings: Make msm8974-pinctrl documentation
 match code
In-Reply-To: <1393441943-1689-1-git-send-email-sboyd@codeaurora.org>
References: <1393441943-1689-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdbrW2YgSpXS4s3MsZbnxS+sT6VYQ6t0i_bSiVom2bdKCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 3:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The compatible string doesn't have an x in it. Fix it. Also
> remove the "qcom" prefix from pins and functions as this binding
> uses the generic pinctrl bindings for the pins and functions.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks Stephen, patch applied with Bj?rn's ACK.

Yours,
Linus Walleij
