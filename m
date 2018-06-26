From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 11:16:18 -0500
Subject: [PATCH v2 02/13] clk: davinci: psc-dm365: use two lookup entries
 for the aemif clock
In-Reply-To: <20180626092537.6737-3-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-3-brgl@bgdev.pl>
Message-ID: <1704809d-07d1-973b-ae92-092eca0426f8@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2018 04:25 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to be able to get the clock both from the board file by its
> con_id and from the aemif driver by dev_id.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
