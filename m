From: briannorris@chromium.org (Brian Norris)
Date: Tue, 21 Mar 2017 12:56:34 -0700
Subject: [PATCH v3 0/4] RK3399 dw-mipi-dsi patches
In-Reply-To: <1489722865-22122-1-git-send-email-zyw@rock-chips.com>
References: <1489722865-22122-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20170321195633.GB74389@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:54:20AM +0800, Chris Zhong wrote:
> Hi all
> 
> This series set the phy_cfg_clk to be a required clock for RK3399, and
> add a grf clock control in dw-mipi-dsi driver. And then correct a
> register name.

Series looks good to me, and works well on RK3399.

Tested-by: Brian Norris <briannorris@chromium.org>
