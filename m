From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 10:27:09 +0200
Subject: [PATCH 1/4] ARM: ux500: Rid ignored return value of
 regulator_enable() compiler warning
In-Reply-To: <1367509690-24022-2-git-send-email-lee.jones@linaro.org>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdacXK-uBsQF=VGfOvh_zZ3ad-A_Zk1Bd-oz+OAUTeXqHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 5:48 PM, Lee Jones <lee.jones@linaro.org> wrote:

> arch/arm/mach-ux500/board-mop500.c: In function ?mop500_prox_activate?:
> arch/arm/mach-ux500/board-mop500.c:406:18: warning: ignoring return value of
>         ?regulator_enable?, declared with attribute warn_unused_result
>         [-Wunused-result]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied!

Thanks,
Linus Walleij
