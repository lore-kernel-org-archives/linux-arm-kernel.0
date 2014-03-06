From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 07:26:59 -0500
Subject: [RESEND Patch 0/3] Prefixes for Kirkwood DT files
In-Reply-To: <1394055207-4639-1-git-send-email-andrew@lunn.ch>
References: <1394055207-4639-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140306122659.GY1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:33:24PM +0100, Andrew Lunn wrote:
> It has been reported that not all these patches made it to the
> list. This is probably because git send-email used UTF8 encoded, since
> some of the hunks contain context lines using none ASCII characters.
> 
> Andrew Lunn (3):
>   DT: I2C: Add trivial bindings used by kirkwood boards
>   DT: Vendors: Add vendor prefix for Macronix

Hmmm, I still didn't receive these two.  I'll check an online archive
later...

thx,

Jason.

>   ARM: Kirkwood: DT: Add missing vendor prefix
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt         | 17 +++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/kirkwood-b3.dts                       |  2 +-
>  arch/arm/boot/dts/kirkwood-cloudbox.dts                 |  2 +-
>  arch/arm/boot/dts/kirkwood-dreamplug.dts                |  2 +-
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts          |  2 +-
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi              |  2 +-
>  arch/arm/boot/dts/kirkwood-nsa310.dts                   |  2 +-
>  arch/arm/boot/dts/kirkwood-nsa310a.dts                  |  2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts            |  2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts            |  2 +-
>  11 files changed, 27 insertions(+), 9 deletions(-)
> 
> -- 
> 1.9.0
> 
