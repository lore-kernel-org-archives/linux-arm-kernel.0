From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 May 2013 13:27:12 +0200
Subject: [PATCH 2/6] ARM: EXYNOS: Fix EINT wake-up mask configuration when
 pinctrl is used
In-Reply-To: <1368807872-2601-3-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-3-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdZ51KBZQTSR7CpqknnQZ8LU+P2p=FFAcUOCV3wXP5foMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 6:24 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> On DT-enabled systems pinctrl-exynos driver is responsible for handling
> of wake-up EINT interrupts. This patch adjusts wake-up mask
> configuration code to take wake-up mask value from pinctrl-exynos driver
> on DT-enabled systems.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Patch applied to my fixes branch for v3.10.

Yours,
Linus Walleij
