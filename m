From: ccross@android.com (Colin Cross)
Date: Thu, 11 Aug 2011 13:54:03 -0700
Subject: [PATCH v2 1/4] gpio/tegra: Remove use of irq_to_gpio
In-Reply-To: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
References: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAMbhsRRGDAmYv3_EbJ+WVg0C7e3-FFcLCgq4W325ECKX06M6Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 1:43 PM, Stephen Warren <swarren@nvidia.com> wrote:
> irq_to_gpio is being removed. Replace the only use of that API by
> the ARM Tegra sub-architecture.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This series is the irq_to_gpio patches I posted last week, rebased to ToT,
> plus removing Tegra's custom gpio_to_irq.
>
> This series was tested against next-20110811 on Harmony, by playing audio
> and plugging/unplugging headphones. Headphone detection relies on using a
> GPIO as an IRQ, and hence on gpio_to_irq.

This whole series looks good to me:
Acked-by: Colin Cross <ccross@android.com>
