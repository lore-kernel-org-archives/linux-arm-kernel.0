From: david@lechnology.com (David Lechner)
Date: Fri, 6 Jul 2018 12:41:22 -0500
Subject: [PATCH v3 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
In-Reply-To: <20180628095748.4462-5-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <20180628095748.4462-5-brgl@bgdev.pl>
Message-ID: <f4964264-55b9-0cb7-c36e-f49d71f689d7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2018 04:57 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to be able to get the clock both from the board file by its
> con_id and from the aemif driver by dev_id.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---


Applied to clk-davinci-4.19.

Thanks.
