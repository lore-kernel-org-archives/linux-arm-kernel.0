From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jan 2015 19:41:02 +0100
Subject: [PATCH v3] ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board
In-Reply-To: <1422383265-6393-1-git-send-email-ats@offog.org>
References: <1422383265-6393-1-git-send-email-ats@offog.org>
Message-ID: <20150127184102.GL7200@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:27:45PM +0000, Adam Sampson wrote:
> Add support for the LinkSprite pcDuino 3 Nano board. This is a low-cost
> Allwinner A20 board with Arduino-style GPIO headers; it features 1G RAM,
> 4G NAND flash, 1 micro-SD, 2 USB sockets, 1 micro USB socket for OTG and
> another for power in, HDMI, SATA, 5V power for SATA devices, gigabit
> Ethernet, an IR receiver, 3.5mm audio out and a MIPI camera connector.
> 
> For more details, see: http://linux-sunxi.org/LinkSprite_pcDuino3_Nano
> 
> Changes in v3:
> - rename LEDs to pcduino3-nano:green:usr[12]
> - remove optional features on Arduino headers (i2c2, spi0, uart2)
> 
> Signed-off-by: Adam Sampson <ats@offog.org>

Applied, thanks.

Note that it will probably only show up in 3.21. The pull requests for
3.20 have been sent this week end, and unless something major and
unexpected shows up, I won't send others.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/ced7f032/attachment.sig>
