From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 08:51:57 +0200
Subject: [PATCH 0/6] ARM: sunxi: Enable AXP PMIC power supplies
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170529065157.2p3pmo3pb4u3fpgr@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 03:31:32PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series enables the power supplies for the AXP PMICs on boards
> that I currently have and am actively testing.
> 
> The first patch re-orders the node references for the Cubieboard 2
> dts, to maintain alphabetical order.
> 
> Patches 2 through 5 enable the ACIN power supply on various boards.
> 
> Patch 6 ties the USB/VBUS power supply of the PMIC to the USB PHY.
> The PHY should have all available methods of VBUS detection configured.
> The Cubietruck already has the power supplies enabled, but the USB
> power supply was not configured to be used for VBUS detection.

Applied all 6, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/904518e0/attachment-0001.sig>
