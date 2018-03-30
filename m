From: david@lechnology.com (David Lechner)
Date: Fri, 30 Mar 2018 12:14:03 -0500
Subject: [PATCH v5 5/8] remoteproc/davinci: prepare and unprepare the
 clock where needed
In-Reply-To: <20180330152856.12297-6-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
 <20180330152856.12297-6-brgl@bgdev.pl>
Message-ID: <4122b904-ee40-db8b-ecd5-813d75b3cba2@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/30/18 10:28 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're currently switching the platform to using the common clock
> framework. We need to explicitly prepare and unprepare the rproc
> clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
