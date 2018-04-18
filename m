From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 10:34:42 +0530
Subject: [PATCH v6 3/7] remoteproc/davinci: add the missing retval check
 for clk_enable()
In-Reply-To: <20180417173038.25510-4-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-4-brgl@bgdev.pl>
Message-ID: <887cabcb-ebb5-0ad9-5bf4-8bb5eba2a017@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> Reviewed-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

This should be safe to apply to v4.17-rc1 and should be queued by Ohad /
Bjorn.

Thanks,
Sekhar
