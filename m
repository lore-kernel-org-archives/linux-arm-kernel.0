From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 17:20:36 -0500
Subject: [PATCHv3] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <557eae062dc044b41088d494f4e6be565699aacd.1385760357.git.arno@natisbad.org>
References: <557eae062dc044b41088d494f4e6be565699aacd.1385760357.git.arno@natisbad.org>
Message-ID: <20131201222036.GC2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 10:29:03PM +0100, Arnaud Ebalard wrote:
> 
> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
> controllers, G751 temperature sensor) except for:
> 
>  - the Intersil ISL12057 I2C RTC Chip,
>  - the Armada NAND controller.
> 
> Support for both of those is currently work in progress and does not
> prevent boot.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
...
> 
>  arch/arm/boot/dts/Makefile                     |   1 +
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 286 +++++++++++++++++++++++++
>  2 files changed, 287 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts

Applied to mvebu/dt

thx,

Jason.
