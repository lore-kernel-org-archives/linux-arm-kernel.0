From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Apr 2012 11:54:34 +0200
Subject: [PATCH 07/11] gpio: tegra: Hide tegra_gpio_enable/disable()
In-Reply-To: <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdaVc3WJE3fo=hp1-om2kd=KLvGWNCbtSjhd0vWa7G-+rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 1:00 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> Recent pinctrl discussions concluded that gpiolib APIs should in fact do
> whatever is required to mux a GPIO onto pins, by calling pinctrl APIs if
> required. This change implements this for the Tegra GPIO driver, and removes
> calls to the Tegra-specific APIs from drivers and board files.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Good stuff. Tegra is starting to look like a role model thanks to your
efforts Stephen.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
