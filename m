From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 21:38:05 +0800
Subject: [PATCH 1/1] imx53.dtsi: Add IPU nodes for csi
In-Reply-To: <1470318452-31391-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
 <1470318452-31391-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <20160809133805.GW4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 03:47:32PM +0200, Fabien Lahoudere wrote:
> We have the following messages that tell csi devices are not used:
> imx-ipuv3 18000000.ipu: no port at 0 node in /soc/ipu at 18000000, not using CSI0
> imx-ipuv3 18000000.ipu: no port at 1 node in /soc/ipu at 18000000, not using CSI1
> 
> So we add them in the common device tree to make CSI ports available on
> imx53 boards.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>

Updated subject 'ARM: dts: imx53: ...', and applied patch.

Shawn
