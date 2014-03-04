From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Mar 2014 16:25:12 +0800
Subject: [PATCH V3 4/5] mfd: palmas: support IRQ inversion at the board
 level
In-Reply-To: <1393876300-3061-4-git-send-email-swarren@wwwdotorg.org>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
 <1393876300-3061-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140304082512.GF10579@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stephen Warren <swarren@nvidia.com>
> 
> Implement the new DT property ti,irq-externally-inverted, and add an
> equivalent platform data field to match. This allows the driver to
> correctly automatically configure the IRQ output polarity when the board
> or SoC contains an inverter between the Palmas IRQ output and IRQ
> controller input.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v3:
> * Use an IRQD flag to represent the data, rather than a custom DT property.
> v2:
> * Split V1's patch 1/2 into separate patches 1/3 and 2/3.
> ---
>  drivers/mfd/palmas.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Looks good to me. Let me know how you want to deal with this. I'm
happy to create an immutable branch for everyone to pull from.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
