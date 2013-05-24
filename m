From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 10:17:12 +0200
Subject: [PATCH 0/3] ARM: ux500: Update defconfigs for MMC
In-Reply-To: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
References: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkda6WYLbNHuVW23mEtQeGfbOZobf_9izeSUppTRdrnv1ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 11:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> This patchset updates the MMC defconfigs in the u8500|u300_defconfig.
>
> Ulf Hansson (3):
>   ARM: ux500: Enable MMC_UNSAFE_RESUME
>   ARM: ux500: Don't use MMC_CLKGATE
>   ARM: ux500: Disable MMC_BLOCK_BOUNCE

Could you please:
- Squash all three into one patch doing all three changes
- Make one patch for ux500 and one for u300

This is because I have different branches for ux500 and u300
so I don't want them to conflict... Doing 6 patches for this seems
a bit too much so 2 should do.

Yours,
Linus Walleij
