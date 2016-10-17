From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 17 Oct 2016 09:57:08 -0700
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <1476721850-454-3-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Mon, 17 Oct 2016 18:30:49 +0200")
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <1476721850-454-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <7h37judicb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Create the driver for the da8xx System Configuration and implement
> support for writing to the three Master Priority registers.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[...]

> +#define DA8XX_IO_PHYS			0x01c00000ul
> +#define DA8XX_SYSCFG0_BASE		(DA8XX_IO_PHYS + 0x14000)

The base addr should come from DT.

Kevin
