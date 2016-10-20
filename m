From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 17:58:24 +0200
Subject: [PATCH v2 2/8] drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
In-Reply-To: <20161020034344.14154-3-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-3-wens@csie.org>
Message-ID: <20161020155824.kzaycvozn22hzmvp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:43:38AM +0800, Chen-Yu Tsai wrote:
> The A31 and A31s also have the DRC as part of the display pipeline.
> As we know virtually nothing about them, just add compatible strings
> for both SoCs to the stub driver.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/3f1833e8/attachment.sig>
