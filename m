From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 Aug 2016 19:47:25 +0800
Subject: [PATCH 1/2] ARM: dts: imx7d: move ARM platform peripherals
 inside soc node
In-Reply-To: <20160726064236.11034-1-stefan@agner.ch>
References: <20160726064236.11034-1-stefan@agner.ch>
Message-ID: <20160815114725.GA32657@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 11:42:35PM -0700, Stefan Agner wrote:
> Since we have a SoC level node we should make use of it and have
> all nodes which are within the SoC, inside that node. This also
> saves an extra interrupt-parent properties. While at it, also
> order the Coresight nodes according to register addresses.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.
