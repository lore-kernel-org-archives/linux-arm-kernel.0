From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:40:17 -0700
Subject: [PATCH v5 8/8] clk: davinci: kill
 davinci_clk_reset_assert/deassert()
In-Reply-To: <20180330152856.12297-9-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
 <20180330152856.12297-9-brgl@bgdev.pl>
Message-ID: <152304721717.94378.15508132666893079542@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bartosz Golaszewski (2018-03-30 08:28:56)
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This code is no longer used. Remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---

I'll try to remember, but please send this again if we need to apply it
to the clk tree for 4.18.

Acked-by: Stephen Boyd <sboyd@kernel.org>
