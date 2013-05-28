From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 May 2013 16:20:50 +0200
Subject: [PATCH] ARM: nomadik: Update MMC defconfigs
In-Reply-To: <1369660566-18997-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369660566-18997-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZ=fX0NLbumOVUDVHPJsYSAFwbT7WNLGhurhPybYnPxGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 3:16 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Enable MMC_UNSAFE_RESUME to accomplish a proper suspend/resume cycle
> for SD/SDIO/(e)MMC.
>
> ARMMMCI host driver supports clock gating through runtime PM, thus
> MMC_CLKGATE is not needed. Moreover ARMMMCI can do scatter-gather which
> means we can explicity disable MMC_BLOCK_BOUNCE, since it's default
> enabled, to skip unnecessary bounce buffer copying.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to my Nomadik defconfig branch.

Yours,
Linus Walleij
