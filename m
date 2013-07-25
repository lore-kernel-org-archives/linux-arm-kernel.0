From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 16:04:16 -0400
Subject: [PATCH 1/2] ARM: Kirkwood: Add support for another ZyXEL
 NSA310 variant
In-Reply-To: <1374079910-24345-2-git-send-email-andrew@lunn.ch>
References: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
 <1374079910-24345-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130725200416.GU23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 06:51:49PM +0200, Andrew Lunn wrote:
> There are a number of variants of the ZyXEL NSA310, with slightly
> different LEDs, buttons and i2c devices. Add a DTS file to support one
> more of these variants.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/Makefile                    |    1 +
>  arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |  107 ++++++++++++++++
>  arch/arm/boot/dts/kirkwood-nsa310.dts         |  100 +--------------
>  arch/arm/boot/dts/kirkwood-nsa310a.dts        |  165 +++++++++++++++++++++++++
>  4 files changed, 274 insertions(+), 99 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-nsa310a.dts

Applied to mvebu/dt

thx,

Jason.
