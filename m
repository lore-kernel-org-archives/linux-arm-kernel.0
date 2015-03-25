From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 11:33:01 -0700
Subject: [PATCH v10 1/2] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1424431168-25157-2-git-send-email-wens@csie.org>
References: <1424431168-25157-1-git-send-email-wens@csie.org>
 <1424431168-25157-2-git-send-email-wens@csie.org>
Message-ID: <20150325183301.GL23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 07:19:27PM +0800, Chen-Yu Tsai wrote:
> From: Carlo Caione <carlo@caione.org>
> 
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> [wens at csie.org: clarify interrupt source for the axp PMIC]
> [wens at csie.org: explain dcdc-workmode in detail and trim lines to 80 chars]
> [wens at csie.org: make regulator supplies optional if using unregulated input]
> [wens at csie.org: use cubieboard2 regulator nodes as example]
> [wens at csie.org: x-powers,dcdc-workmode default changed to 'current hardware
>                 setting']
> [wens at csie.org: reorganized regulator related properties into separate
>                 section.]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/fd901d83/attachment.sig>
