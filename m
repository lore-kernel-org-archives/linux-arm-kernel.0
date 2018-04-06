From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:38:35 -0700
Subject: [PATCH v5 3/8] clk: davinci: add a reset lookup table for psc0
In-Reply-To: <20180330152856.12297-4-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
 <20180330152856.12297-4-brgl@bgdev.pl>
Message-ID: <152304711592.94378.4448268823064394140@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bartosz Golaszewski (2018-03-30 08:28:51)
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to be able to use the reset framework in legacy boot mode as
> well, add the reset lookup table to the psc driver for da850 variant.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Applied to clk-next
