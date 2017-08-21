From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Aug 2017 10:40:53 +0200
Subject: [PATCH] ARM: sun8i: a33: add dts for Q8 tablets with different
 resolution
In-Reply-To: <20170817074926.3410-1-icenowy@aosc.io>
References: <20170817074926.3410-1-icenowy@aosc.io>
Message-ID: <20170821084053.s4qmhlvgsmckmqgh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 03:49:26PM +0800, Icenowy Zheng wrote:
> Q8 tablets with Allwinner A33 SoC now come with two kind of LCD, either
> 800x480 or 1024x600.
> 
> In order for sun4i-drm to be able to choose correct LCD configuration,
> two different device trees should be present, one for a resolution.
> 
> Add stub device trees for two resolutions.
> 
> As the sun4i-drm driver still has some problems to support the LCDs, the
> real LCD device nodes are not added to the device tree files.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This should be an overlay, ideally applied by the bootloader.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/b83ee581/attachment.sig>
