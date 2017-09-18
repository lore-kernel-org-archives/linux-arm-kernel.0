From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 09:34:52 +0200
Subject: [PATCH v4 2/6] iio: adc: sun4i-gpadc-iio: rename A33-specified
 registers to contain A33
In-Reply-To: <20170914145251.21784-3-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-3-icenowy@aosc.io>
Message-ID: <20170918073452.2jizidgu4rvqesiq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 10:52:47PM +0800, Icenowy Zheng wrote:
> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A33, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A33".
> 
> Add "_A33" after "SUN8I" on the register names.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/d14378cb/attachment.sig>
