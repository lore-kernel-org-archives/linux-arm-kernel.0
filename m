From: david@lechnology.com (David Lechner)
Date: Fri, 6 Jul 2018 12:41:34 -0500
Subject: [PATCH v3 05/13] clk: davinci: psc-da830: add a lookup entry for
 aemif clock
In-Reply-To: <20180628095748.4462-6-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <20180628095748.4462-6-brgl@bgdev.pl>
Message-ID: <0160fde6-51af-aa3e-81cb-a73ae56f35b3@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2018 04:57 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to use the ti-aemif platform driver for da830-evm. To make it
> work we need a lookup entry for the aemif clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---


Applied to clk-davinci-4.19.

Thanks.
