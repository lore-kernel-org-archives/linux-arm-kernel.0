From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 22:00:44 +0800
Subject: [PATCH] ARM: imx: fix missing includes
In-Reply-To: <1465406620-29671-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465406620-29671-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160611140044.GR20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 06:23:40PM +0100, Ben Dooks wrote:
> Fix the following warnings by adding the include files
> that define them:
> 
> arch/arm/mach-imx/devices/devices.c:25:15: warning: symbol 'mxc_aips_bus' was not declared. Should it be static?
> arch/arm/mach-imx/devices/devices.c:29:15: warning: symbol 'mxc_ahb_bus' was not declared. Should it be static?
> arch/arm/mach-imx/devices/devices.c:33:12: warning: symbol 'mxc_device_init' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
