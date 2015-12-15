From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Dec 2015 16:57:41 +0800
Subject: [PATCH] I.MX6: Fix Ethernet PHY mode on Ventana boards
In-Reply-To: <m3r3itaznn.fsf@t19.piap.pl>
References: <m3r3itaznn.fsf@t19.piap.pl>
Message-ID: <20151215085741.GG25756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 02:22:04PM +0100, Krzysztof Ha?asa wrote:
> Gateworks Ventana boards seem to need "RGMII-ID" (internal delay)
> PHY mode, instead of simple "RGMII", for their Marvell 88E1510
> transceiver. Otherwise, the Ethernet MAC doesn't work with Marvell PHY
> driver (TX doesn't seem to work correctly).
> 
> Tested on GW5400 rev. C.
> 
> This bug affects ARM Fedora 23.
> 
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
> Acked-by: Tim Harvey <tharvey@gateworks.com>
> Cc: stable at vger.kernel.org

Applied with patch subject changed to "ARM: dts: imx6: Fix Ethernet PHY
mode on Ventana boards".

Shawn
