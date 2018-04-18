From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 10:57:07 +0530
Subject: [PATCH v6 4/7] remoteproc/davinci: prepare and unprepare the
 clock where needed
In-Reply-To: <20180417173038.25510-5-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-5-brgl@bgdev.pl>
Message-ID: <a0c390ae-53fe-5d17-1ebf-d55e805f4118@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're currently switching the platform to using the common clock
> framework. We need to explicitly prepare and unprepare the rproc
> clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> Reviewed-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

This should be safe to apply to v4.17-rc1 as well (for inclusion in v4.18).

Bartosz, I noticed that CONFIG_REMOTEPROC and the DA8XX driver is not
enabled in davinci_all_defconfig. Can you please send a patch enabling
that too?

Thanks,
Sekhar
