From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Jan 2015 10:48:34 +0100
Subject: [PATCH v3] pinctrl: exynos: Add support for Exynos5433
In-Reply-To: <1421822591-10536-1-git-send-email-cw00.choi@samsung.com>
References: <1421822591-10536-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CACRpkdYq-1ztF5baHjB9aBUNspD5vRXrpnEd1zdWsADmwrhuWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 7:43 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> This patch adds driver data for Exynos5433 SoC. Exynos5433 includes 228 multi-
> functional input/output port pins and 135 memory port pins. There are 41 general
> port groups and 2 memory port groups.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> ---
> Changes from v2:
> - Rebase it on v3.19-rc5

Waiting for Tomasz to review this.

Yours,
Linus Walleij
