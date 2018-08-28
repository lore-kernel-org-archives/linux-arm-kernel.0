From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Aug 2018 08:53:51 -0700
Subject: [PATCH] Fix file permission for am335x-osd3358-sm-red.dts
In-Reply-To: <20180828153816.1152-1-neeraj.dantu@octavosystems.com>
References: <20180828153816.1152-1-neeraj.dantu@octavosystems.com>
Message-ID: <20180828155351.GN7523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Neeraj Dantu <dantuguf14105@gmail.com> [180828 15:42]:
> OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> Octavo Systems.
> 
> This board family can be indentified by the A335BNLTOS00 in the at24 eeprom:
> A2: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 4f 53 30 30 |.U3.A335BNLTOS00|]
> 
> https://octavosystems.com/octavo_products/osd3358-sm-red/

Hmm can you please repost with a correct patch description?
Something along the lines of:

Fix wrong mode for dts file added by commit bb3e3fbbac86
("ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED
based on TI AM335x").

Regards,

Tony

> Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Robert Nelson <robertcnelson@gmail.com>
> CC: Jason Kridner <jkridner@gmail.com>
> ---
> Changes:
> - Fix file permission
> ---
>  arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> 
> diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> old mode 100755
> new mode 100644
> -- 
> 2.7.4
> 
