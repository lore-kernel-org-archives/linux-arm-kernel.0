From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2011 23:04:26 +0200
Subject: [PATCH v4 0/7] add initial imx6q support
In-Reply-To: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201109302304.26953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Shawn Guo wrote:
> 
> This patch series adds the initial support for imx6q, which is a
> Cortex-A9 Quad Core based SoC.
> 
> We chose to add imx6q support into mach-imx other than mach-mx5 or
> a new mach-mx6, because we intend to merge mach-mx5 into mach-imx, so
> that we have only mach-imx for imx family.
> 
> It's based on linux-next-20110926 with some prerequisite patches
> not showing up on linux-next applied.

How should we best proceed on this series? Sascha, do you want to
take the next version into your tree once Shawn has addressed the
remaining comments, or should I just take the patches with your
Ack?

Shawn, what are the current dependencies? I will have to pull
in the other branches that this depends on into the next/soc
tree and then wait for those to get merged first before I send
this to Linus.

	Arnd
