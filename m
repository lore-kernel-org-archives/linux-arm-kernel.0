From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 10:08:49 +0100
Subject: [PATCH v3 07/13] pinctrl: samsung: Add missing initconst
 annotation
In-Reply-To: <1484833733-16082-8-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170119134907eucas1p14be6b994bddf37f8baca669a66acc1d4@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Exynos5433 support has been added in parallel to adding initconst
> annotation to most of the init data structures, so add those
> annotations also to Exynos5433 structures.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

This fails to apply to the pinctrl tree "devel" branch.

I guess I have other Samsung patches on the branch colliding
with this.

Can you please rebase this and the following patches on this
branch and resend?
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
