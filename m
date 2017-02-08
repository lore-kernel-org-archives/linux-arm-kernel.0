From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 09:01:42 +0100
Subject: [PATCH v4 2/9] clk: sunxi-ng: rename sun8i-h3 driver to
 sunxi-h3-h5
In-Reply-To: <20170207183042.62699-3-icenowy@aosc.xyz>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
 <20170207183042.62699-3-icenowy@aosc.xyz>
Message-ID: <20170208080142.u3ouhen5lewdeg2l@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 02:30:35AM +0800, Icenowy Zheng wrote:
> As the CCU in the Allwinner H5 SoC is very similar to the one in H3,
> rename the H3 driver to sunxi-h3-h5 so that it can be extended with H5
> support.

Saying why you create a symbolic link for your headers in your commit
log would be great.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/d8c2bd2d/attachment.sig>
