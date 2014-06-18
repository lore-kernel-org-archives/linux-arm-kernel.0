From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 12:17:34 +0200
Subject: [PATCH v2 13/20] clk: sunxi: Add A23 specific compatible to
 sun6i-a31-apb0-gates-clk
In-Reply-To: <1403016777-15121-14-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-14-git-send-email-wens@csie.org>
Message-ID: <20140618101734.GP19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:50PM +0800, Chen-Yu Tsai wrote:
> The sun6i-a31-apb0-gates-clk driver is generic in that it supports
> the "clock-indicies" DT property with "clock-output-names" to list
> the valid clock gate bits.
> 
> However this might lead one to assume that the clock in the A23 is
> the same as the A31. To make it clear, we add a new compatible for
> the A23, "allwinner,sun8i-a23-apb0-gates-clk".
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/7c15c288/attachment.sig>
