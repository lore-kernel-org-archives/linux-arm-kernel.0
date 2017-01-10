From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 18:54:14 +0100
Subject: [PATCH v3] ARM: dts: sun7i: Add wifi dt node on Banana Pro
In-Reply-To: <20170109203638.29546-1-joerg.krause@embedded.rocks>
References: <20170109203638.29546-1-joerg.krause@embedded.rocks>
Message-ID: <20170110175414.vxun2dju5y5c4wja@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 09:36:38PM +0100, J?rg Krause wrote:
> The Banana Pro has an AMPAK AP6181 WiFi+Bluetooth module. The WiFi part
> is a BCM43362 IC connected to MMC3 of the A20 SoC via SDIO. The IC also
> takes a power enable signal via GPIO.
> 
> This commit adds a device-tree node to power it up, so the mmc subsys
> can scan it, and enables the mmc controller which is connected to it.
> 
> As the wifi enable pin of the AP6181 module is not really a regulator,
> switch the mmc3 node to the mmc-pwrseq framework for controlling it.
> This more accurately reflectes how the hardware actually works.
> 
> Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/caa18787/attachment.sig>
