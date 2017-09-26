From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:56:47 +0200
Subject: [PATCH v2 05/13] drm/sun4i: hdmi: create a regmap for later use
In-Reply-To: <20170926065919.24446-6-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-6-wens@csie.org>
Message-ID: <20170926095647.o4p72dd6n3257n5m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:11AM +0000, Chen-Yu Tsai wrote:
> The HDMI driver is written with readl/writel I/O to the registers.
> However, to support the A31 variant, which has a different layout
> for the DDC registers, it was recommended to use regfields to have
> a cleaner implementation. To use regfields, we need to create an
> underlying regmap.
> 
> This patch only adds the regmap. It does not convert the existing
> driver accesses to use regmap.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/9d844f65/attachment.sig>
