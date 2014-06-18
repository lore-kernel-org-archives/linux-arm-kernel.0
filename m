From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:10:06 +0200
Subject: [PATCH v2 03/20] clk: sunxi: move "ahb_sdram" to protected clock
 list
In-Reply-To: <1403016777-15121-4-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-4-git-send-email-wens@csie.org>
Message-ID: <20140618091006.GI19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:40PM +0800, Chen-Yu Tsai wrote:
> With sunxi_gates clocks registered with clkdev, we can use the
> protected clocks list to enable the "ahb_sdram" clock, instead
> of looking for it and adding CLK_IGNORE_UNUSED inline in the
> clock setup code.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/23c9801a/attachment.sig>
