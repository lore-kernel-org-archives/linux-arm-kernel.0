From: ccross@google.com (Colin Cross)
Date: Tue, 22 Feb 2011 11:58:26 -0800
Subject: [PATCH 1/4] ARM: tegra: Fix typo in TEGRA_IRQ_TO_GPIO
In-Reply-To: <1298173137-9242-2-git-send-email-swarren@nvidia.com>
References: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
	<1298173137-9242-2-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTikdM8mQX2vmJT62f1zK5Ztfrj3wcASxwSQFff0j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 7:38 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> ?arch/arm/mach-tegra/include/mach/gpio.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
> index e31f486..12a7cf6 100644
> --- a/arch/arm/mach-tegra/include/mach/gpio.h
> +++ b/arch/arm/mach-tegra/include/mach/gpio.h
> @@ -31,7 +31,7 @@
> ?#define gpio_cansleep ? ? ? ? ?__gpio_cansleep
>
> ?#define TEGRA_GPIO_TO_IRQ(gpio) (INT_GPIO_BASE + (gpio))
> -#define TEGRA_IRQ_TO_GPIO(irq) ((gpio) - INT_GPIO_BASE)
> +#define TEGRA_IRQ_TO_GPIO(irq) ((irq) - INT_GPIO_BASE)
>
> ?static inline int gpio_to_irq(unsigned int gpio)
> ?{
> --
> 1.7.1
>
>

Pushed to for-next
