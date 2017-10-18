From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 10:51:25 +0800
Subject: [PATCH 2/6] ARM: dts: imx51-ts4800: Fix 'port@0' node with unit
 name and no reg property
In-Reply-To: <1508158110-5188-2-git-send-email-marco.franchi@nxp.com>
References: <1508158110-5188-1-git-send-email-marco.franchi@nxp.com>
 <1508158110-5188-2-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171018025124.GH18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 10:48:26AM -0200, Marco Franchi wrote:
> The following build warning is seen with W=1:
> 
> Warning (unit_address_vs_reg): Node /display-di0/port at 0 has a unit name, but no reg property
> 
> Fix this warning by removing '@' from such node.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

This patch and #6 do not apply to imx/dt branch.  Please rebase.

Shawn
