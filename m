From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 16:16:23 +0200
Subject: [PATCH] ARM: ux500: u8500_defconfig: Enable PARTITION_ADVANCED
In-Reply-To: <1395839947-2534-1-git-send-email-ulf.hansson@linaro.org>
References: <1395839947-2534-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdYeJJDCtrLxPh7z7nOBSe4Xz7rv1fu462DBhpOMDOwNCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 2:19 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There are both (e)MMC/SD-card support in ux500, thus it's reasonable to
> support partitions for block devices as default.
>
> While updating the defconfig, we rebase it towards Kconfig changes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to the linux-stericsson tree.

Yours,
Linus Walleij
