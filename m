From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:51:17 +0200
Subject: [PATCH v3 7/7] ARM: sunxi: update the default ARCH_NR_GPIO for
 sunxi arch
In-Reply-To: <1397137966-30818-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdYT9HvG6dOVOEnBSNhRt847tdCsAU6E_dZLdFQEHntpKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> The A31 SoC has PL and PM banks and thus increase the default ARCH_NR_GPIO.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied, and grrrr we need to get rid of these static #gpios defines
in the long run.

ARM SoC folks: notice this hitting arch/arm/Kconfig, complain if it's
problematic.

Yours,
Linus Walleij
