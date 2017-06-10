From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 Jun 2017 11:24:53 +0200
Subject: [PATCH] ARM: sun8i: h3: Enable EMAC with external PHY on Orange
 Pi Plus 2E
In-Reply-To: <20170609153436.18370-1-wens@csie.org>
References: <20170609153436.18370-1-wens@csie.org>
Message-ID: <20170610092453.wl3gymli4m4eiqam@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 11:34:36PM +0800, Chen-Yu Tsai wrote:
> The Orange Pi Plus 2E, unlike the Orange Pi PC and PC Plus which its
> schematics are based on, uses an external Realtek RTL8211E PHY in
> RGMII mode, with a GPIO enabling the regulator for I/O signalling
> power supplies. The PHY's main power supply is enabled by the main
> 5V power supply.
> 
> Add the regulator and PHY nodes, and override the PHY phandle under
> the EMAC node, so that the EMAC works properly on this board.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170610/1d16f45d/attachment-0001.sig>
