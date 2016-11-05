From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 19:47:00 +0800
Subject: [PATCH] ARM: dts: imx6: Add imx-weim parameters to dtsi's
In-Reply-To: <1478044305-5666-1-git-send-email-stillcompiling@gmail.com>
References: <1478044305-5666-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <20161105114658.GI5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 04:51:45PM -0700, Joshua Clayton wrote:
> imx-weim should always set address-cells to 2,
> and size_cells to 1.
> On imx6, fsl,weim-cs-gpr will always be &gpr
> 
> Set these common parameters in the dtsi file,
> rather than in a downstream dts.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

Applied, thanks.
