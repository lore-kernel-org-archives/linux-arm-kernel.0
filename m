From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jun 2018 10:20:06 +0800
Subject: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
In-Reply-To: <20180618154257.16919-1-manu@freebsd.org>
References: <20180618154257.16919-1-manu@freebsd.org>
Message-ID: <20180628022005.GF22683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 05:42:57PM +0200, Emmanuel Vadot wrote:
> The RIoTboard debug uart is connected to serial1.
> Add a chosen property in the DTS so OS knows what serial port to use for
> the console.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Applied, thanks.
