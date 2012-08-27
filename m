From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 09:39:31 -0700
Subject: [PATCH] mxs/spi: Add SPI slave mode operation DT prop
In-Reply-To: <1345776161-9778-1-git-send-email-marex@denx.de>
References: <1345776161-9778-1-git-send-email-marex@denx.de>
Message-ID: <20120827163930.GG4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 04:42:41AM +0200, Marek Vasut wrote:
> This allows user to select the slave mode of operation of the controller.
> This is by no means standard, see the binding documentation for details,
> there is plenty of them. Sadly, such knowledge is not provided in the chip
> documentation. Hopefully, this mode of operation might come useful for
> people who do know very well what they are doing, otherwise this should
> never be touched.

I was going to touch this but I appear to have misplaced my bargepole :)

More seriously as you say this is a bit controversial so given that
Grant's now finished his move and should reappear soon I'll punt for
now.
