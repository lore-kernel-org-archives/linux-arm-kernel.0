From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 20 Jul 2018 10:48:09 +0800
Subject: [PATCH] ARM: dts: imx7d: remove "operating-points" property for
 cpu1
In-Reply-To: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
References: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180720024808.GZ4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 04:24:19PM +0800, Anson Huang wrote:
> Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> added "operating-points" property for all CPUs, but i.MX7D already has
> "operating-points-v2" property on both CPUs, so no need to add
> "operating-points" property again, this patch removes it.
> 
> Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
