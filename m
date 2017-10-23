From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 08:39:01 +0800
Subject: [PATCH v3 1/6] ARM: dts: imx51-apf51dev: Fix 'backlight@bl1'
 node with unit name and no reg property
In-Reply-To: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
References: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171023003900.GD8700@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 01:48:22PM -0200, Marco Franchi wrote:
> The following build warning is seen with W=1:
> 
> Warning (unit_address_vs_reg): Node /backlight at bl1 has a unit name, but no reg property
> 
> Fix this warning by removing '@bl1'from such node and change 'bl1grp' to 
> 'backlightgrp', once there is only one backlight in this dts.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied #1 ~ #5, thanks.
