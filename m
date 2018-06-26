From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 11:18:11 -0500
Subject: [PATCH v2 05/13] clk: davinci: psc-da830: add a lookup entry for
 aemif clock
In-Reply-To: <20180626092537.6737-6-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-6-brgl@bgdev.pl>
Message-ID: <302fdaed-1f18-992f-805e-aa320ac34305@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2018 04:25 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to use the ti-aemif platform driver for da830-evm. To make it
> work we need a lookup entry for the aemif clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
