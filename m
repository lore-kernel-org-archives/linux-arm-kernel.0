From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:47:11 +0200
Subject: [PATCH 02/22] clk: sunxi: register clock gates with clkdev
In-Reply-To: <1400831485-28576-3-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-3-git-send-email-wens@csie.org>
Message-ID: <20140525184711.GO10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:05PM +0800, Chen-Yu Tsai wrote:
> The new important clock protect code requires the clocks be
> registered with clkdev. This was missing for sunxi_gates
> type clocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/89bbe452/attachment-0001.sig>
