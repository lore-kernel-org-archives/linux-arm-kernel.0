From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Jan 2016 10:36:25 +0100
Subject: [PATCH v2 2/3] pinctrl: qcom: Use platform_irq_count() instead of
 of_irq_count()
In-Reply-To: <1452130661-13157-1-git-send-email-sboyd@codeaurora.org>
References: <CAJAp7OhNxTzsRSq7MHfBCbp3F+vaw6tS99eMBw8FbWLunudiKQ@mail.gmail.com>
 <1452130661-13157-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdYN73UpnY6mGbj_OBk3DtGxLHh_FdbKEMzMDWNxxbcbMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 2:37 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> of_irq_count() is not an exported symbol (and it shouldn't be
> used by platform drivers anyway) so use platform_irq_count()
> instead. This allows us to make the qcom pinctrl drivers modular
> again.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn@kryo.se>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> Changes from v1:
>  * Fixed one wrong of_irq_count() noticed by Bjorn

This v2 patch applied.

Yours,
Linus Walleij
