From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Thu, 4 Jan 2018 14:39:47 +0100
Subject: [PATCH v3 05/11] ARM: sun8i: h3/h5: add DE2 CCU device node for H3
In-Reply-To: <20171222122243.25735-6-icenowy@aosc.io>
References: <20171222122243.25735-1-icenowy@aosc.io>
 <20171222122243.25735-6-icenowy@aosc.io>
Message-ID: <20180104133947.slerf6m52suarmym@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 08:22:37PM +0800, Icenowy Zheng wrote:
> The DE2 in H3/H5 has a clock control unit in it, and the behavior is
> slightly different between H3 and H5.
> 
> Add the common parts in H3/H5 DTSI, and add the compatible string in H3
> DTSI.
> 
> The compatible string of H5 DE2 CCU will be added in a separated patch.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Use H3 DE2 CCU compatible as it's discovered that H3 and A83T DE2 CCU are
>   not equal.
> 
>  arch/arm/boot/dts/sun8i-h3.dtsi    |  4 ++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 14 ++++++++++++++

Could you split that patch in half, with the common part in one patch,
and the H3 part in a second one?

This is a nightmare to merge otherwise.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/59c0ba21/attachment.sig>
