From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 28 Oct 2012 20:11:50 +0100
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <1351089457-8205-3-git-send-email-t.figa@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <1351089457-8205-3-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:37 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch modifies the Samsung GPIO driver to check for pinctrl driver
> presence earlier and use generic matching instead of a single compatible
> value.
>
> This allows us to fix warning about unrecognized SoC in case of
> Exynos4x12, which is not supported by this driver.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if there is something you want merged through
the GPIO or pinctrl tree. I have this Samsung branch on the
pinctrl tree...

Yours,
Linus Walleij
