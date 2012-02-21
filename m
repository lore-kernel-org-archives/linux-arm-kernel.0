From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Feb 2012 11:44:35 +0100
Subject: [PATCH 2/2] gpio: tegra: Delete tegra_gpio_enable/disable()
In-Reply-To: <1329719263-18971-2-git-send-email-swarren@nvidia.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <1329719263-18971-2-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdYDVU9TAVAAw=uBp84puED0kGkdSW8goAJRG1Nc=6xCaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Recent pinctrl discussions concluded that gpio_request() and other gpiolib
> APIs should in fact do whatever is required to mux a GPIO onto pins, by
> calling pinctrl APIs if required. This change implements this for the
> Tegra GPIO driver, and removes the old Tegra-specific APIs which did this.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I don't believe this depends on other patches.
>
> There may be some slight context dependencies; this patch was generated
> against next-20120217, with my recently posted "gpio: tegra: Fix build
> issue due to irq_domain rework." applied on top.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Since it mainly touches mach-tegra stuff I think it's best to take
this through the Tegra tree, Olof can you queue it?

Yours,
Linus Walleij
