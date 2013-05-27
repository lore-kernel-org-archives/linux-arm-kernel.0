From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 15:34:30 +0200
Subject: [PATCH] ARM: u300: Update MMC configs for u300 defconfig
In-Reply-To: <1369658515-18774-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369658515-18774-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdYTrcfbB9qD5ZEvEKivuUo+YYWfTWVtvL092X-EOw1nBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 2:41 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

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

Thanks, patch applied to my u300 branch!

Yours,
Linus Walleij
