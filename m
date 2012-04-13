From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Apr 2012 14:41:16 +0200
Subject: [PATCH] pinctrl: tegra: refactor probe handling
In-Reply-To: <1334170839-10396-1-git-send-email-swarren@wwwdotorg.org>
References: <1334170839-10396-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdZQneBCOGp8oL2O4+J0OnOeW7NUHt2Eo7sKqQ_4jSGKLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 9:00 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Rather than having a single tegra-pinctrl driver that determines whether
> it's running on Tegra20 or Tegra30, instead have separate drivers for
> each that call into utility functions to implement the majority of the
> driver. This change is based on review feedback of the SPEAr pinctrl
> driver, which had originally copied to Tegra driver structure.
>
> This requires that the two drivers have unique names. Update a couple
> spots in arch/arm/mach-tegra for the name change.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Linus, It'll be easiest for me to merge this through the Tegra tree, since
> the arch/arm changes depend on the patches there that switch to using the
> pinctrl driver. If you could ack this, it'd be great. Thanks.

Sure,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
