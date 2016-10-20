From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 17:58:46 +0200
Subject: [PATCH v2 3/8] drm/sun4i: tcon: Move SoC specific quirks to a DT
 matched data structure
In-Reply-To: <20161020034344.14154-4-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-4-wens@csie.org>
Message-ID: <20161020155846.5nxgxy2xfgmagxtn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:43:39AM +0800, Chen-Yu Tsai wrote:
> We already have some differences between the 2 supported SoCs.
> More will be added as we support other SoCs. To avoid bloating
> the probe function with even more conditionals, move the quirks
> to a separate data structure that's tied to the compatible string.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/b7c51e84/attachment.sig>
