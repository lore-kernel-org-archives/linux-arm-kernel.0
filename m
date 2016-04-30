From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Apr 2016 10:32:35 +0200
Subject: [PATCH] arm64: vulcan: enable GPIOLIB in Kconfig
In-Reply-To: <1461819767-17539-1-git-send-email-kamlakant.patel@broadcom.com>
References: <1461819767-17539-1-git-send-email-kamlakant.patel@broadcom.com>
Message-ID: <CACRpkdY07afPyo35Fh25FXPCXED8UymbwS3AbqFnGauSmRHMwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 7:02 AM,  <kamlakant.patel@broadcom.com> wrote:

> From: Kamlakant Patel <kamlakant.patel@broadcom.com>
>
> Add select GPIOLIB in Kconfig for Broadcom Vulcan ARM64 GPIO driver.
>
> Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

But don't you also want to select the actual driver?

Yours,
Linus Walleij
