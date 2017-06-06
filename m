From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jun 2017 20:37:57 +0200
Subject: [PATCH 1/2] arm64: allwinner: a64: add DTSI file for SoPine SoM
In-Reply-To: <20170604024345.23021-1-icenowy@aosc.io>
References: <20170604024345.23021-1-icenowy@aosc.io>
Message-ID: <20170606183757.lvpdlxj3rn4z2u2r@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 10:43:44AM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> SoPine is a SoM by Pine64, which have a gold finger compatible with the
> slot of DDR3 SODIMM (signals are not compatible), and have an A64, an
> AXP803, a LPDDR3 DRAM chip, a power led and a MicroSD slot on it.
> 
> The card detect pin of the MicroSD slot on the SoM is pulled down, which
> makes it unusable; however, the slot is at the surface of the SoM that
> is closed to the baseboard, so it's nearly impossible to hot-swap it,
> thus I make it non-removable.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/70b49317/attachment.sig>
