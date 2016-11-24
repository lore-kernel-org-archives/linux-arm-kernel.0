From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 21:00:36 +0100
Subject: [PATCH 0/2] ARM: dts: sun6i: Disable display pipeline by default
In-Reply-To: <20161124064339.12615-1-wens@csie.org>
References: <20161124064339.12615-1-wens@csie.org>
Message-ID: <20161124200036.d2u66w4aan7syq2h@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 02:43:37PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> While we now support the internal display pipeline found on sun6i, it
> is possible that we are unable to enable the display for some boards,
> due to a lack of drivers for the panels or bridges found on them. If
> the display pipeline is enabled, the driver will try to enable, and
> possibly screw up the simple framebuffer U-boot had configured.
> 
> This series disables the display pipeline by default, and re-enables
> it for the A31 Hummingbird, which already had its display pipeline
> enabled.
> 
> The series can go in after 4.10-rc1, as a fix, but should not be delayed
> till the next release.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/fc6a71f2/attachment.sig>
