From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 09:01:09 +0200
Subject: [PATCHv2] pinctrl: exynos: Add driver data for Exynos3250
In-Reply-To: <1397439947-31592-1-git-send-email-cw00.choi@samsung.com>
References: <1397439947-31592-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CACRpkdaycY=Mba1pYQMv-Yq87JGfyJEnwmrT+qwDhrZ_4Rqs+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 3:45 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> From: Tomasz Figa <t.figa@samsung.com>
>
> This patch adds driver data (bank list and EINT layout) for Exynos3250
> to pinctrl-exynos driver. Exynos3250 includes 158 multi-functional input/output
> ports. There are 23 general port groups.
>
> Changes from v1:
> - Add signed-off of sender
> - Post only separated patch for pinctrl from following patchset(v1)
>   : https://lkml.org/lkml/2014/4/10/286
>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

This v2 patch applied.

Yours,
Linus Walleij
