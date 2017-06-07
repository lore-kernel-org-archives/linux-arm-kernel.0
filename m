From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jun 2017 15:27:07 +0200
Subject: [PATCH 3/3] arm64: allwinner: h5: enable dwmac-sun8i for Nano Pi
 NEO2
In-Reply-To: <20170607002305.15897-3-icenowy@aosc.io>
References: <20170607002305.15897-1-icenowy@aosc.io>
 <20170607002305.15897-3-icenowy@aosc.io>
Message-ID: <20170607132707.nh2icuxnbest6swx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 08:23:05AM +0800, Icenowy Zheng wrote:
> Add the required DT parts to enable Ethernet (dwmac-sun8i driver) on
> the Nano Pi NEO2 board. It uses an external Realtek RTL8211E PHY
> connected via RGMII to provide GbE network. Specially unlike other
> Allwinner boards, the phy is connected to MDIO address 7, not 1.
> 
> This includes the regulator (which is controlled by a GPIO pin) and
> the actual Ethernet MAC node, referring the RGMII pins of the device.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied all three, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/b86079d1/attachment.sig>
