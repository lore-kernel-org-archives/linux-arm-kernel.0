From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Dec 2015 11:07:50 +0800
Subject: [PATCH] ARM: dts: imx: Fix the assigned-clock mismatch issue on
 imx6q/dl
In-Reply-To: <1449648955-30835-1-git-send-email-b51503@freescale.com>
References: <1449648955-30835-1-git-send-email-b51503@freescale.com>
Message-ID: <20151214030750.GF25756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 04:15:55PM +0800, Bai Ping wrote:
> The 'assigned-clock-parents' and 'assigned-clock-rates' list
> should corresponding to the 'assigned-clocks' property clock list.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>

Applied, thanks.
