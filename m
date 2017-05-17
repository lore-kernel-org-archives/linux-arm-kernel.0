From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 19:37:39 +0200
Subject: [PATCH v8 0/9] Initial Allwinner Display Engine 2.0 Support
In-Reply-To: <20170517144725.3463-1-icenowy@aosc.io>
References: <20170517144725.3463-1-icenowy@aosc.io>
Message-ID: <20170517173739.c7mxj6gr2buhaoes@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 10:47:16PM +0800, Icenowy Zheng wrote:
> This patchset is the initial patchset for Allwinner DE2 support.
> 
> As the DE2 CCU support is already applied, this patchset now contains
> only DRM changes and device tree changes. 
> 
> The SoC used to develop this patchset is V3s, as V3s is the simplest
> one of the SoCs that have DE2.
> 
> (Allwinner V3s features only one mixer, and its only video output is
> RGB LCD, which is already supported in our TCON driver)
> 
> The last patch is only a testing patch, it shouldn't be merged; and
> for the patch to be really usable, the RFC fix of the TCON driver [1]
> is needed.
> 
> No HDMI, TV encoder or other internal bridges' support is included
> in this patchset, which makes it currently not usable on H3.
> 
> Thanks to Jean-Francois Moine and Jernej Skrabec for their efforts
> to discover the internal of DE2!
> 
> [1] https://lists.freedesktop.org/archives/dri-devel/2016-December/126264.html
> 
> Icenowy Zheng (9):
>   drm/sun4i: abstract a engine type
>   drm/sun4i: add a dedicated module for sun4i-backend and sun4i-layer
>   drm/sun4i: add a Kconfig option for sun4i-backend
>   drm/sun4i: add support for Allwinner DE2 mixers
>   drm/sun4i: Add compatible string for V3s display engine
>   drm/sun4i: tcon: add support for V3s TCON

Applied all those patches...

>   ARM: sun8i: v3s: add device nodes for DE2 display pipeline

But this one doesn't apply. Please rebase and resend.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170517/0d5275dc/attachment.sig>
