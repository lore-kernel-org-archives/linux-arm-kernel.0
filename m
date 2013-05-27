From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:10:47 +0200
Subject: [PATCH 1/6] ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices
In-Reply-To: <1369314830-3727-2-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdYisqexALz8sKrLQsCHxn9Z8TeShXOdTTv_TUZudBByKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> We are able to cope with an SDMMC clock of 100MHz so let's
> make use of the full frequency instead of the half.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to my ux500-core changes tree.

Yours,
Linus Walleij
