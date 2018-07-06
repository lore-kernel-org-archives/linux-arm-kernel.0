From: david@lechnology.com (David Lechner)
Date: Fri, 6 Jul 2018 12:40:37 -0500
Subject: [PATCH v3 02/13] clk: davinci: psc-dm365: use two lookup entries
 for the aemif clock
In-Reply-To: <20180628095748.4462-3-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <20180628095748.4462-3-brgl@bgdev.pl>
Message-ID: <57167844-663e-a43d-7892-74ba4da42903@lechnology.com>
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
