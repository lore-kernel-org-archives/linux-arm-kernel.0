From: david@lechnology.com (David Lechner)
Date: Fri, 30 Mar 2018 12:12:30 -0500
Subject: [PATCH v5 3/8] clk: davinci: add a reset lookup table for psc0
In-Reply-To: <20180330152856.12297-4-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
 <20180330152856.12297-4-brgl@bgdev.pl>
Message-ID: <a96712b7-2f2d-5a6d-a37a-a43063fb801b@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/30/18 10:28 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to be able to use the reset framework in legacy boot mode as
> well, add the reset lookup table to the psc driver for da850 variant.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
