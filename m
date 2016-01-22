From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jan 2016 21:44:02 +0100
Subject: [PATCH RFC 12/15] ARM: dts: sun9i: Use sun9i specific mmc
 compatible
In-Reply-To: <1453354002-28366-13-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-13-git-send-email-wens@csie.org>
Message-ID: <20160122204402.GE3682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 01:26:39PM +0800, Chen-Yu Tsai wrote:
> sun9i/A80 MMC controllers have a larger FIFO, and the FIFO DMA
> trigger levels can be increased. Also, the mmc module clock parent
> has a higher clock rate, and the sample and output delay phases
> are different.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Does that count as a fix, or does the A80 board can safely operate
without it?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160122/db75ee10/attachment.sig>
