From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:59:40 +0200
Subject: [PATCH 11/22] ARM: sun6i: DT: Add PLL6 multiple outputs
In-Reply-To: <1400831485-28576-12-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-12-git-send-email-wens@csie.org>
Message-ID: <20140525185940.GS10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:14PM +0800, Chen-Yu Tsai wrote:
> PLL6 on sun6i has multiple outputs, just like the other sunxi platforms.

Which outputs?

If it's the PLLx2, PLLx4 and PLLx8, like I said, use fixed factor
clocks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/bd54121a/attachment-0001.sig>
