From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 14:35:18 -0700
Subject: [PATCH v6] clk: lpc32xx: Set name of regmap_config
In-Reply-To: <20180319035854.3265-1-jeffy.chen@rock-chips.com>
References: <20180319035854.3265-1-jeffy.chen@rock-chips.com>
Message-ID: <152149531811.242365.11094328182208620465@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jeffy Chen (2018-03-18 20:58:54)
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Applied to clk-next
