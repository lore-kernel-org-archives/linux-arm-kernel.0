From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 02 Oct 2018 12:58:52 -0700
Subject: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
In-Reply-To: <20180828005056.27326-1-nm@ti.com>
References: <20180828005056.27326-1-nm@ti.com>
Message-ID: <153851033263.119890.1832482570043652816@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nishanth Menon (2018-08-27 17:50:56)
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to clk-next
