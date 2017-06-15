From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Jun 2017 10:24:07 +0800
Subject: [PATCH] ARM: dts: ls1021a: update the clockgen node
In-Reply-To: <1496989545-27282-1-git-send-email-andy.tang@nxp.com>
References: <1496989545-27282-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170615022406.GF30112@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 02:25:45PM +0800, Yuantian Tang wrote:
> qoriq clock driver has been updated to parse the clock configuration
> information defined in driver itself not in dts.
> Since the new implementation and the bindings have been merged,
> it is time to update the clock related node and remove redundent clock
> configuration information from the dts.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied, thanks.
