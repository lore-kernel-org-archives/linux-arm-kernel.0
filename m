From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 16:34:27 +0800
Subject: [PATCH v1] ARM: dts: imx6qdl-sabreauto: add ecspi dts for
 sabreauto board
In-Reply-To: <1521627768-942-1-git-send-email-yibin.gong@nxp.com>
References: <1521627768-942-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180416083426.GF25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 06:22:48PM +0800, Robin Gong wrote:
> DIN pin of SPI-NOR muxed with I2C3_SDA which connected to one gpio expand
> chip, thus have to disable all those module which compacted by those gpios
> if enable SPI-NOR support on Sabreauto board.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

I'm not in the position to maintain a bunch of dts files for a single
board with different device multiplexing options.

Shawn
