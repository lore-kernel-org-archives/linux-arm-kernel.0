From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 19:33:17 +0200
Subject: [RESEND PATCH 2/2] mmc: mmci: Switching off HWFC for SDIO depends
 on MCLK
In-Reply-To: <1349885000-22887-2-git-send-email-ulf.hansson@stericsson.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
 <1349885000-22887-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbWVLJKroUgX_kSO4Mwgxfhe3gZO9701xmpDuQJKx7sOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For writes, HWFC shall be switched off when transfer size <= 8
> bytes and when MCLK rate is above 50 MHz. For 50MHz and below
> it shall be switched off when transfer size < 8 bytes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
