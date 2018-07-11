From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 11 Jul 2018 21:14:32 +0800
Subject: [PATCH V2 2/2] ARM: dts: imx6sx: add ocram_s support
In-Reply-To: <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
 <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180711131431.GJ6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 08:58:59AM +0800, Anson Huang wrote:
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, enable it as another mmio sram.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Since the clock ID has already been defined before, this dts patch can
be applied independently to clock driver one.

Applied, thanks.
