From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 13:24:44 +0100
Subject: [PATCH v5 2/7] clk: sunxi-ng: rename sun8i-h3 driver to
 sunxi-h3-h5
In-Reply-To: <20170226011956.53581-3-icenowy@aosc.xyz>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-3-icenowy@aosc.xyz>
Message-ID: <20170227122444.6523qu4wwm4ihlfx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 26, 2017 at 09:19:51AM +0800, Icenowy Zheng wrote:
> As the CCU in the Allwinner H5 SoC is very similar to the one in H3,
> rename the H3 driver to sunxi-h3-h5 so that it can be extended with H5
> support.
> 
> Trasitional header symlinks are created, to ensure current device tree
> files which included sun8i-h3-ccu.h can compile.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Just like for the R40, I wonder whether this is needed at all. We have
a lot of other drivers that we don't have to rename to support new
SoCs. This is kind of weird to make an exception for this one only.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/d4422d54/attachment.sig>
