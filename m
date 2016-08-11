From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 10:19:32 +0200
Subject: [PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP bindings
In-Reply-To: <20160711190109.16758-1-sboyd@codeaurora.org>
References: <20160711190109.16758-1-sboyd@codeaurora.org>
Message-ID: <CACRpkdazPheA1s2FX2ugEyCFmrKiq36QEmEuCGJRt-vQTFWFVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 9:01 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> The drivers don't really need to know which PMIC they're for, so
> make a generic binding for them. This alleviates us from updating
> the drivers every time a new PMIC comes out. It's still
> recommended that we update the binding with new PMIC models and
> always specify the specific model for the MPPs and gpios before
> the generic compatible string in devicetree, but this at least
> cuts down on adding more and more compatible strings to the
> drivers until we actually need them.
>
> Cc: <devicetree@vger.kernel.org>
> Acked-by: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
