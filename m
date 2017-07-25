From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 16:49:13 +0800
Subject: [PATCH v4 1/2] ARM: dts: imx7d-sdb: Add DRM panel support
In-Reply-To: <1500307934-22160-1-git-send-email-marco.franchi@nxp.com>
References: <1500307934-22160-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20170725084912.GH20064@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 01:12:13PM -0300, Marco Franchi wrote:
> It is preferred to use the panel compatible string rather than passing the
> LCD timming in the device tree.
> 
> So pass the "innolux,at043tn24" compatible string to describe the parallel
> LCD on this board.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied both, thanks.
