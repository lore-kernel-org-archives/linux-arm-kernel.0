From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 16:59:14 +0100
Subject: [PATCH v2 7/9] dmaengine: sun6i: allow build on ARM64 platforms
 (sun50i)
In-Reply-To: <20170126154859.55855-8-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-8-icenowy@aosc.xyz>
Message-ID: <20170127155914.fwbssmehlgwf5q7j@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:57PM +0800, Icenowy Zheng wrote:
> As 64-bot Allwinner H5 SoC has the same DMA engine with H3, the DMA
> driver should be allowed to be built for ARM64, in order to make it work on H5.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/5091fa26/attachment.sig>
