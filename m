From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 09:13:23 +0200
Subject: [PATCH 2/2] arm64: allwinner: a64: add pmu0 regs for USB PHY
In-Reply-To: <20170405143034.8868-3-icenowy@aosc.io>
References: <20170405143034.8868-1-icenowy@aosc.io>
 <20170405143034.8868-3-icenowy@aosc.io>
Message-ID: <20170406071323.isaowk3qh3rdu7lh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 10:30:34PM +0800, Icenowy Zheng wrote:
> The USB PHY in A64 has a "pmu0" region, which controls the EHCI/OHCI
> controller pair that can be connected to the PHY0.
> 
> Add the MMIO region for PHY node.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/72ad759f/attachment.sig>
