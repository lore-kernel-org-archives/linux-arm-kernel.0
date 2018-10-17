From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 11:28:35 -0700
Subject: [PATCH 4/6] clk: mvebu: ap806: Fix clock name for the cluster
In-Reply-To: <20180922181709.13007-5-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-5-gregory.clement@bootlin.com>
Message-ID: <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-09-22 11:17:07)
> Actually, the clocks exposed for the cluster are not the CPU clocks, but
> the PLL clock used as entry clock for the CPU clocks. The CPU clock will
> be managed by a driver submitting in the following patches.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Does this need a fixes tag?
