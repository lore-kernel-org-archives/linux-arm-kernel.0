From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 13:41:56 -0700
Subject: [RFC PATCH 07/10] clk: rockchip: set clk-ddr to GET_RATE_NOCACHE.
In-Reply-To: <20180514211610.26618-8-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-8-enric.balletbo@collabora.com>
Message-ID: <152641691632.237094.11483387696003404182@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Enric Balletbo i Serra (2018-05-14 14:16:07)
> From: Derek Basehore <dbasehore@chromium.org>
> 
> This adds the flag to the clk-ddr in rockchip to not use the cached
> rate for get_rate. This is to handle timeout error conditions in SMC
> for the set rate function.

We need some more information here. Why does timeout error condition in
set_rate() matter for get_rate()?
