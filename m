From: briannorris@chromium.org (Brian Norris)
Date: Thu, 16 Mar 2017 17:34:17 -0700
Subject: [PATCH v2 0/4] RK3399 dw-mipi-dsi patches
In-Reply-To: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
References: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20170317003416.GC8180@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 11:31:43AM +0800, Chris Zhong wrote:
> Hi all
> 
> This series set the phy_cfg_clk to be a required clock for RK3399, and
> add a grf clock control in dw-mipi-dsi driver. And then correct a
> register name.
> 
> 
> Changes in v2:
> - check the grf_clk only for RK3399

For the series:

Tested-by: Brian Norris <briannorris@chromium.org>
