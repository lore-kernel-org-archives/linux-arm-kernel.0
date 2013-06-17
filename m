From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 21:31:34 +0800
Subject: [GIT PULL] ARM: mxs: device tree changes for 3.11
In-Reply-To: <20130617125159.GG31687@S2101-09.ap.freescale.net>
References: <20130617125159.GG31687@S2101-09.ap.freescale.net>
Message-ID: <20130617133131.GB4537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 08:52:01PM +0800, Shawn Guo wrote:
> Arnd, Olof,
> 
> Here is the device tree changes for 3.11.  There are a couple of
> patches which should be soc changes.  I collected them on mxs/dt branch
> and sent them together with device tree pull request here, considering
> the volume for soc changes in this cycle is not high.  Hope it's fine.

Forgot mentioning that there is a trivial conflict with branch
machdesc/cleanup on arch/arm/mach-mxs/mach-mxs.c.  linux-next has
the resolution for reference.

Shawn
