From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 11:15:55 -0500
Subject: [PATCH v2 01/13] clk: davinci: psc-da850: remove the
 'davinci_nand.0" lookup
In-Reply-To: <20180626092537.6737-2-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-2-brgl@bgdev.pl>
Message-ID: <543c4ebf-4212-1933-9672-f8e29ba4d303@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2018 04:25 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit a8e3923ab571 ("mtd: rawnand: davinci: don't acquire and
> enable clock") we no longer acquire the aemif clock from the davinci
> nand driver - we only do it from the ti-aemif driver. Remove the nand
> entry from the psc lookup table.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
