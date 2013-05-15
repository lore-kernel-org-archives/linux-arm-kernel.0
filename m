From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 May 2013 20:58:06 -0400
Subject: [PATCH] ARM: Kirkwood: Enable USB 3.0 in kirkwood_defconfig
In-Reply-To: <1368542544-24743-1-git-send-email-andrew@lunn.ch>
References: <1368542544-24743-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130515005806.GK31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 04:42:24PM +0200, Andrew Lunn wrote:
> Some QNAP devices has a USB 3.0 host controller on a PCIe bus.  Enable
> the driver for this in the default configuration.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/kirkwood_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
