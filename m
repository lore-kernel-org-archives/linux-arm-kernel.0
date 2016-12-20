From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 19:58:20 +0100
Subject: [PATCH] ARM: dts: sun8i: add a delay after reset xr819 on Orange
 Pi Zero
In-Reply-To: <20161220055826.30725-1-icenowy@aosc.xyz>
References: <20161220055826.30725-1-icenowy@aosc.xyz>
Message-ID: <20161220185820.r5jmrac4toywk6te@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 01:58:26PM +0800, Icenowy Zheng wrote:
> XR819 seems to need a delay after its reset line to be deasserted,
> otherwise it may not respond MMC commands correctly, and fail to
> initialize.
> 
> Add a 200ms delay in the mmc-pwrseq.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/4f8055a3/attachment.sig>
