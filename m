From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 10:59:07 +0200
Subject: [PATCH 4/4] ARM: sun8i: v3s: add support for Lichee Pi Zero w/
 dock board
In-Reply-To: <20170515084001.63123-4-icenowy@aosc.io>
References: <20170515084001.63123-1-icenowy@aosc.io>
 <20170515084001.63123-4-icenowy@aosc.io>
Message-ID: <20170515085907.cyitd47elgsy4cq4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 04:40:01PM +0800, Icenowy Zheng wrote:
> The Lichee Pi Zero board has a "dock board" which needs to be soldered
> with the 1.27mm stamp holes on a Lichee Pi Zero board.
> 
> It features:
> - Onboard MIC and headphone jack (not supported yet)
> - Ethernet port (not supported yet)
> - An extra MicroSD slot connected to MMC1 controller
> - four keys connected to the LRADC.
> 
> As it needs to be soldered with the main board to use, add a stand-alone
> device tree for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied all 4, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/20742b63/attachment.sig>
