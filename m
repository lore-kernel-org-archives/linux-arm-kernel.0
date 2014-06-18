From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 12:06:21 +0200
Subject: [PATCH v2 10/20] clk: sunxi: Add support for table-based divider
 clocks
In-Reply-To: <1403016777-15121-11-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-11-git-send-email-wens@csie.org>
Message-ID: <20140618100621.GN19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:47PM +0800, Chen-Yu Tsai wrote:
> A few of the clock modules have odd dividers, such as
> the 2 lowest dividers being the same (2), or have the
> same divider when the highest bit is set.
> 
> This patch adds support for optional divider tables,
> so the clock framework will know about the odd values.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/e675d062/attachment.sig>
