From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 14:43:12 +0200
Subject: [PATCH] pinctrl: imx: update fsl, pins description in bindings doc
In-Reply-To: <1381301531-19212-1-git-send-email-shawn.guo@linaro.org>
References: <1381301531-19212-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYs4BEEywt6JaS0+v4tWhV8-VJkUr+A-7E_xL1N8DOWnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 8:52 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> While commit e164153 (pinctrl: imx: move hard-coding data into device
> tree) moves to use DTC macro for imx pinctrl device tree setting, it
> changes the semantics of fsl,pins without updating the bindings doc
> properly.  Let's update the fsl,pins description to stop confusing
> people.
>
> While at it, the example in the document is updated, and the stale TODO
> gets removed.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied.

Yours,
Linus Walleij
