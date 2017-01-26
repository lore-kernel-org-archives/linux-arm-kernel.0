From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 16:36:21 +0100
Subject: [PATCH v3 REBASED 10/13] pinctrl: samsung: Add infrastructure for
 pin-bank retention control
In-Reply-To: <1485422967-30643-7-git-send-email-m.szyprowski@samsung.com>
References: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
 <CGME20170126093001eucas1p2531400b718191fd5fadd71d9f0c83597@eucas1p2.samsung.com>
 <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com>
 <1485422967-30643-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CACRpkdZxk-FE4K1kbiHCXgiGVb4F53eJbsZ2vdLd55qTALY9ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:29 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
>
> This patch adds infrastructure to handle pad retention during pin control
> driver resume.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied.

Yours,
Linus Walleij
