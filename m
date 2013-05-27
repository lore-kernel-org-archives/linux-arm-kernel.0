From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 14:35:30 +0200
Subject: [PATCH] ARM: ux500: Update MMC configs for u8500 defconfig
In-Reply-To: <1369657815-16236-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369657815-16236-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdYqBR-azYEpSTCATuuSP99v+qy72PyMt6MoDwVF_qF0vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 2:30 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Enable MMC_UNSAFE_RESUME to be accomplish a proper suspend/resume cycle
> for SD/SDIO/(e)MMC.
>
> ARMMMCI host driver supports clock gating through runtime PM, thus
> MMC_CLKGATE is not needed. Moreover ARMMMCI can do scatter-gather which
> means we can explicity disable MMC_BLOCK_BOUNCE, since it's default
> enabled, to skip unnecessary bounce buffer copying.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, patch applied to my ux500-defconfig branch.

Yours,
Linus Walleij
