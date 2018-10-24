From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:48:48 -0700
Subject: [PATCH v2 03/15] clk: sunxi-ng: Add check for maximum rate to NKM
 PLLs
In-Reply-To: <20181023155035.9101-4-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-4-jagan@amarulasolutions.com>
Message-ID: <154037092824.53599.14201561893996103915@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jagan Teki (2018-10-23 08:50:23)
> Some NKM PLLs, frequency can be set above PLL working range.
> 
> Add a constraint for maximum supported rate. This way, drivers can
> specify which is maximum allowed rate for PLL.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
