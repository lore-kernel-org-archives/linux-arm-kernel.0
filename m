From: david@lechnology.com (David Lechner)
Date: Tue, 26 Jun 2018 11:17:04 -0500
Subject: [PATCH v2 03/13] clk: davinci: psc-dm644x: use two lookup entries
 for the aemif clock
In-Reply-To: <20180626092537.6737-4-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-4-brgl@bgdev.pl>
Message-ID: <ab355923-89bf-c574-9f0a-2f7abd984762@lechnology.com>
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
