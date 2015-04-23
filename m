From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Apr 2015 22:30:24 +0200
Subject: [PATCH v2] ARM: dts: sun7i: Add dts file for the Jesurun Q5 top
 set box
In-Reply-To: <1429792010-22359-1-git-send-email-hdegoede@redhat.com>
References: <1429792010-22359-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150423203024.GG28007@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 02:26:50PM +0200, Hans de Goede wrote:
> The Jesurun Q5 has a black plastic casing with the approximate dimensions
> of 100mm x 100mm x 24mm with rounded edges. In terms of hardware it
> features an Allwinner A10 SoC with 1GB RAM and 8GB of NAND flash. The
> external connectors are: 2x USB-A female supporting USB2.0, 3.5mm female
> jack for audio, HDMI female, SPDIF, RJ45 LAN and Power. In addition the
> device has 1x red LED (hard wired to power) and an programmable green led.
> On the board there is also an unpopulated IR receiver and the UART.
> The devices is equipped with an AXP209 PMU.
> 
> For more details see: http://linux-sunxi.org/Jesurun_Q5
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued for 4.2, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150423/b1dde949/attachment.sig>
