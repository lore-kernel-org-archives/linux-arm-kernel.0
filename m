From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 17:21:17 -0500
Subject: [PATCHv0] ARM: kirkwood: Add support for NETGEAR ReadyNAS NV+ v2
In-Reply-To: <58e99356aad0daf90d28162eac6a4ecec70470f8.1385822676.git.arno@natisbad.org>
References: <58e99356aad0daf90d28162eac6a4ecec70470f8.1385822676.git.arno@natisbad.org>
Message-ID: <20131201222117.GD2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 04:13:44PM +0100, Arnaud Ebalard wrote:
> 
> Almost all hardware parts of the NETGEAR ReadyNAS NV+ v2 ([1] for more
> details) are supported by mainline kernel. The only missing elements in
> provided .dts file are:
> 
>  - the front LCD module (Winstar WINSTAR WH1602): driver development is
>    ongoing. This is the same LCD module as on ReadyNAS 104.
>  - the Macronix MX25L512 512Kbit SPI flash: no time to play with it yet.
> 
> The device is the big brother (4 vs 2 bay) of the ReadyNAS Duo v2. The
> main differences are some additional LEDs for the disks, a Marvell
> 88SM4140 SATA Port multiplier (no driver required to access the disk)
> and previously described LCD module. Otherwise, it shares the same SoC
> (kirkwood 88F6282), RAM (256MB), NAND (128MB), RTC chip (Ricoh rs5c372a),
> fan controller (GMT G762), XHCI controller (NEC/Renesas ?PD720200).
> 
> [1]: http://natisbad.org/NAS5/
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
...
> 
>  arch/arm/boot/dts/Makefile                         |   1 +
>  .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 270 +++++++++++++++++++++
>  2 files changed, 271 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts

Applied to mvebu/dt

thx,

Jason.
