From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Jun 2018 15:42:23 +0800
Subject: [PATCH 1/2] ARM: dts: imx6: make edt-ft5x06 a wakeup source for
 imx6 boards
In-Reply-To: <20180523083013.7570-1-daniel@zonque.org>
References: <20180523083013.7570-1-daniel@zonque.org>
Message-ID: <20180611074222.GE16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 10:30:12AM +0200, Daniel Mack wrote:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Applied, thanks.
