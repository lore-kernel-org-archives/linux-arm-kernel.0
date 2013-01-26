From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 15:39:28 -0500
Subject: [PATCH 1/2] ARM: Kirkwood: topkick: Fix SoC type and add
 missing pins
In-Reply-To: <1359219326-5927-1-git-send-email-andrew@lunn.ch>
References: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
 <1359219326-5927-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130126203928.GS1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 05:55:24PM +0100, Andrew Lunn wrote:
> Topkick contains a Marvell 6282, not an 6281 as included in the
> kirkwood-topkick.dts file.
> 
> Also, add pinhogs for the serial port and nand devices.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-topkick.dts |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Squashed into pinctrl conversion, thanks and good catch.

thx,

Jason.
