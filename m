From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 19:17:23 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001
 board
In-Reply-To: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121027191723.23a691a2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sat, 27 Oct 2012 18:22:45 +0200, Gregory CLEMENT wrote:
> This platform, available from Globalscale has an Armada 370. For now,
> only the serial port is supported. Support for network, USB and other
> peripherals will be added as drivers for them become available for
> Armada 370 in mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile          |    3 ++-
>  arch/arm/boot/dts/mbx001.dts        |   37 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mvebu/armada-370-xp.c |    1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/mbx001.dts

With the rename mbx001.dts -> mbx0001.dts, this works fine for me on
the hardware platform, so:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
