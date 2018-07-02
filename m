From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jul 2018 17:27:21 +0530
Subject: [PATCH v7 3/4] ARM: davinci: dts: make psc0 a reset provider
In-Reply-To: <20180621073706.22812-4-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-4-brgl@bgdev.pl>
Message-ID: <b56077f5-c8ef-6c19-7b2e-c82eec23d127@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The psc driver registers with the reset framework as a provider. Add
> the #reset-cells property to the psc0 node.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>

Applied to v4.19/dt branch of my tree.

Thanks,
Sekhar
