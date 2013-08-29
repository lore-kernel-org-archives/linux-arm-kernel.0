From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 14:42:25 +0200
Subject: [PATCH] gpio: samsung: Drop support for Exynos SoCs
In-Reply-To: <1377538555-14901-1-git-send-email-t.figa@samsung.com>
References: <1377538555-14901-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdbUo2t1gT8=6UpjiXs4Sd-1xLpEqOqdA220L0wgVC-4uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 7:35 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> GPIO support on Exynos SoCs is provided by pinctrl-samsung driver,
> leaving all the support code in gpio-samsung driver unused.

Just double checking: you mean it is unused in v3.11-rc7 OK?
Not in Linux-next?

In the former case I can merge it into the GPIO tree and in the
latter case I need to merge it into the pinctrl tree.

> This dead
> code can be safely removed and so it is done by this patch.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Tentatively applied to the gpio tree.

Yours,
Linus Walleij
