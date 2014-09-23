From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 17:18:20 +0200
Subject: [PATCH v2 1/5] pinctrl: exynos: Generalize the eint16_31 demux
 code
In-Reply-To: <1411460169-30536-2-git-send-email-a.kesavan@samsung.com>
References: <1411460169-30536-1-git-send-email-a.kesavan@samsung.com>
 <1411460169-30536-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <CACRpkdZcN0Zszt9QmW309fYDjOm-syA9kpL8nhRK640eKNB1Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 10:16 AM, Abhilash Kesavan
<a.kesavan@samsung.com> wrote:

> The function exynos_irq_demux_eint16_31 uses pre-defined offsets for external
> interrupt pending status and mask registers. So this function is not extensible
> for Exynos7 SoC which have these registers at different offsets. So generalize
> the exynos_irq_demux_eint16_31 function by using the pending/mask register
> offset values from the exynos_irq_chip structure.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
> Tested-by: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

I'm waiting for the maintainers to ACK these patches
before I take them.

Yours,
Linus Walleij
