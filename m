From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2012 01:12:58 +0200
Subject: [PATCH v4 4/4] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
In-Reply-To: <1335529578-14507-4-git-send-email-b29396@freescale.com>
References: <1335529578-14507-1-git-send-email-b29396@freescale.com>
 <1335529578-14507-4-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbE=fFhTr=MyD-2dgV=W07Kb-T+ax4dgdjZ8ONzoz3K7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 2:26 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> This driver is shared between many platforms. Currently only imx6q has
> pinctrl support, to avoid breaking other platforms that do not have pinctrl
> support to run this driver, enable pinctrl dummy state for them before
> they also convert to pinctrl subsystem.
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> This patch depends on:
> pinctrl: add pinctrl_provide_dummies interface for platforms to use
> http://www.spinics.net/lists/arm-kernel/msg171538.html

I cannot apply this unless I get the i.MX maintainers ACK on it
(and I fear creating a lot of merge conflicts...)

If I cannot apply it there are two ways to proceed:
1. Wait for next merge window
2. Pull pinctrl into i.MX tree

Yours,
Linus Walleij
