From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Oct 2017 10:14:16 +0200
Subject: [PATCH] ARM: dts: sun5i: reference-design-tablet: Enable AXP209
 AC and battery
In-Reply-To: <20171012080542.21862-1-wens@csie.org>
References: <20171012080542.21862-1-wens@csie.org>
Message-ID: <20171012081416.ievcy4yj7yyg4c3l@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 08:05:42AM +0000, Chen-Yu Tsai wrote:
> The reference design tablet has the DC jack wired to AXP209's ACIN.
> As a tablet, it also has an internal LiPo battery, wired to the PMIC's
> battery charger.
> 
> Enable both.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171012/c52b27fa/attachment-0001.sig>
