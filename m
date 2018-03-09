From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 10:31:37 +0800
Subject: [PATCH v4 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for
 busy divider and busy mux
In-Reply-To: <1520502445-22576-1-git-send-email-ping.bai@nxp.com>
References: <1520502445-22576-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180309023136.GD3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 05:47:22PM +0800, Bai Ping wrote:
> The busy divider and busy mux is actually used by the system critical clocks,
> so add 'CLK_IS_CRITICAL' to clocks registered with these two type.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

"clk: imx: ..." for patch prefix is good enough.

Shawn
