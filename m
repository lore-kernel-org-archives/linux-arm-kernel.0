From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 22:01:07 +0800
Subject: [PATCH] ARM: imx: fix missing include of common.h
In-Reply-To: <1465406777-336-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465406777-336-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160611140107.GS20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 06:26:17PM +0100, Ben Dooks wrote:
> Fix the following warning by including ../common.h to provide
> the protoype for mxc_register_gpio() :
> 
> arch/arm/mach-imx/devices/platform-gpio-mxc.c:11:24: warning: symbol 'mxc_register_gpio' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
