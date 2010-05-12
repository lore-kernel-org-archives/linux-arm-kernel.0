From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 May 2010 11:28:39 +0100
Subject: [PATCH v2] ARM: S5PV210: Add S5PV210 GPIO support.
In-Reply-To: <1273659531-6151-1-git-send-email-kgene.kim@samsung.com>
References: <1273659531-6151-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100512102839.GA22371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 07:18:51PM +0900, Kukjin Kim wrote:
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <mach/map.h>
> +#include <mach/gpio.h>

It's linux/gpio.h
